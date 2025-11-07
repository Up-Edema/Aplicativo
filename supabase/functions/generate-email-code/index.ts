// file: simulate_email.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.39.7";

serve(async (req) => {
  try {
    // aceita apenas POST com JSON { "email": "destino@exemplo.com" }
    if (req.method !== "POST") {
      return new Response(JSON.stringify({ error: "Use POST" }), { status: 405 });
    }

    const body = await req.json().catch(() => ({}));
    const email = (body?.email ?? "").toString().trim();

    if (!email) {
      return new Response(JSON.stringify({ error: "Missing email" }), { status: 400 });
    }

    // cria cliente Supabase (usando SERVICE ROLE para permitir inserts/deletes)
    const supabase = createClient(
      Deno.env.get("PROJECT_URL") ?? "",
      Deno.env.get("SERVICE_ROLE_KEY") ?? ""
    );

    // gera código e expiração
    const code = Math.floor(1000 + Math.random() * 9000).toString();
    const expiresAt = new Date(Date.now() + 5 * 60 * 1000).toISOString();

    // remove códigos anteriores e insere o novo
    const del = await supabase.from("email_verification_codes").delete().eq("email", email);
    if (del.error) {
      // não fatal — só debug; continua
      console.warn("Warn deleting old codes:", del.error.message);
    }

    const insert = await supabase.from("email_verification_codes").insert({
      email,
      code,
      expires_at: expiresAt,
      used: false
    });

    if (insert.error) {
      return new Response(JSON.stringify({
        error: "Erro ao inserir código no Supabase",
        detail: insert.error.message
      }), { status: 500 });
    }

    // HTML que seria enviado (simulação)
    const html = `
      <div style="font-family: Arial, Helvetica, sans-serif; max-width:600px; margin:0 auto;">
        <h2>Confirmação de e-mail (SIMULAÇÃO)</h2>
        <p>Olá — este e-mail é apenas uma simulação para testes locais. Nenhum e-mail real foi enviado.</p>
        <p>Use o código abaixo para confirmar seu e-mail no aplicativo:</p>
        <h1 style="color:#27ae60; letter-spacing:8px;">${code}</h1>
        <p style="color:#888; font-size:14px;">Expira em 5 minutos — ${expiresAt}</p>
      </div>
    `;

    // Retorna tudo para o cliente testar UI/fluxo
    return new Response(JSON.stringify({
      success: true,
      message: "Simulação realizada com sucesso (nenhum e-mail enviado)",
      to: email,
      subject: "Seu código de verificação (simulação)",
      code,
      expires_at: expiresAt,
      html_preview: html
    }), {
      status: 200,
      headers: { "Content-Type": "application/json" }
    });

  } catch (err) {
    console.error("Unhandled error:", err);
    return new Response(JSON.stringify({
      error: err?.message ?? "Unexpected error"
    }), { status: 500 });
  }
});


















// import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
// import { createClient } from "https://esm.sh/@supabase/supabase-js@2.39.7";

// serve(async (req) => {
//   try {
//     const { email } = await req.json();

//     if (!email) {
//       return new Response(JSON.stringify({
//         error: "Missing email"
//       }), { status: 400 });
//     } 

//     const supabase = createClient(
//       Deno.env.get("PROJECT_URL") ?? "",
//       Deno.env.get("SERVICE_ROLE_KEY") ?? ""
//     );

//     const code = Math.floor(1000 + Math.random() * 9000).toString();
//     const expiresAt = new Date(Date.now() + 5 * 60 * 1000).toISOString();

//     await supabase
//       .from("email_verification_codes")
//       .delete()
//       .eq("email", email);

//     const { error: insertError } = await supabase
//       .from("email_verification_codes")
//       .insert({
//         email,
//         code,
//         expires_at: expiresAt,
//         used: false
//       });

//     if (insertError) {
//       return new Response(JSON.stringify({
//         error: insertError.message
//       }), { status: 500 });
//     }

//     const html = `
//       <h2>Confirmação de e-mail</h2>
//       <p>Use o código abaixo para confirmar seu e-mail no aplicativo:</p>
//       <h1 style="color:#27ae60; letter-spacing:8px;">${code}</h1>
//       <p>Este código expira em 5 minutos.</p>
//     `;

//     const resendKey = Deno.env.get("RESEND_API_KEY");
//     const emailFrom = Deno.env.get("EMAIL_FROM");

//     if (!resendKey || !emailFrom || !html || !email) {
//       return new Response(JSON.stringify({
//         error: "Missing to, subject or html",
//         debug: { emailFrom, email, html, resendKey }
//       }), { status: 400 });
//     }

//     const emailRes = await fetch("https://api.resend.com/emails", {
//       method: "POST",
//       headers: {
//         "Authorization": `Bearer ${resendKey}`,
//         "Content-Type": "application/json"
//       },
//       body: JSON.stringify({
//         from: emailFrom,
//         to: email,
//         subject: "Seu código de verificação",
//         html
//       })
//     });

//     if (!emailRes.ok) {
//       const errorBody = await emailRes.text();
//       return new Response(JSON.stringify({ error: errorBody }), { status: 500 });
//     }

//     return new Response(JSON.stringify({ success: true }), { status: 200 });

//   } catch (err) {
//     return new Response(JSON.stringify({
//       error: err.message ?? "Unexpected error"
//     }), { status: 500 });
//   }
// });
