import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.39.7"

serve(async (req: Request) => {
  try {
    const { user_id, email } = await req.json();

    if (!user_id && !email) {
      return new Response(
        JSON.stringify({ error: "Missing user_id or email" }),
        { status: 400 },
      );
    }

  const supabase = createClient(
    Deno.env.get('PROJECT_URL')!,
    Deno.env.get('SERVICE_ROLE_KEY')!
  )

    let userId = user_id as string | undefined;

    if (!userId && email) {
      const { data: profile, error: profileError } = await supabase
        .from("profiles")
        .select("id")
        .eq("email", email)
        .maybeSingle();

      if (profileError) {
        return new Response(
          JSON.stringify({ error: profileError.message }),
          { status: 500 },
        );
      }

      if (!profile || !profile.id) {
        return new Response(
          JSON.stringify({ error: "User not found for provided email" }),
          { status: 404 },
        );
      }

      userId = profile.id as string;
    }

    if (!userId) {
      return new Response(
        JSON.stringify({ error: "Unable to resolve user_id" }),
        { status: 400 },
      );
    }

    const code = Math.floor(1000 + Math.random() * 9000).toString();
    const expiresAt = new Date(Date.now() + 5 * 60 * 1000).toISOString();

    await supabase.from("email_verification_codes").delete().eq("user_id", userId);

    const { error: insertError } = await supabase
      .from("email_verification_codes")
      .insert({
        user_id: userId,
        code,
        expires_at: expiresAt,
      });

    if (insertError) {
      return new Response(
        JSON.stringify({ error: insertError.message }),
        { status: 500 },
      );
    }

    const html = `
      <h2>Confirmação de e-mail</h2>
      <p>Use o código abaixo para confirmar seu e-mail no aplicativo:</p>
      <h1 style="color:#27ae60; letter-spacing:8px;">${code}</h1>
      <p>Este código expira em 5 minutos.</p>
    `;

    const { error: emailError } = await supabase.functions.invoke("send-email", {
      body: {
        to: email,
        subject: "Seu código de verificação",
        html,
      },
    });

    if (emailError) {
      return new Response(
        JSON.stringify({ error: emailError.message }),
        { status: 500 },
      );
    }

    return new Response(
      JSON.stringify({ success: true }),
      { status: 200 },
    );
  } catch (err) {
    return new Response(
      JSON.stringify({ error: (err as Error).message ?? "Unexpected error" }),
      { status: 500 },
    );
  }
});