# Sending real verification emails

Registration and password-reset codes are always logged to the server
console (`[EmailIdp] Registration code (...): 123456`), so local dev works
with zero setup. To also have them actually emailed to the user, point the
server at a Gmail account:

1. Turn on 2-Step Verification on the Gmail account you want to send from,
   if it isn't already: <https://myaccount.google.com/security>.
2. Create an App Password: <https://myaccount.google.com/apppasswords>.
   Pick any name (e.g. "Mess Manager server") — Google gives you a
   16-character password. This is **not** your normal Gmail password, and
   normal passwords won't work here since 2-Step Verification is on.
3. Open `config/passwords.yaml` (this file is git-ignored — it never gets
   committed) and fill in the two placeholders under `shared`:
   ```yaml
   shared:
     gmailAddress: 'youraccount@gmail.com'
     gmailAppPassword: 'the16characterapppassword'
   ```
4. Restart the server. From then on, every registration/password-reset
   code is both logged and emailed.

Leaving the placeholders as-is is fine — the server just skips sending and
keeps using the console log.
