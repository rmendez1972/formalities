/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
public class mail {
    private final Properties properties = new Properties();
    private Session session;
    private Boolean exito=false;
    private void init() {
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.starttls.enable", "true");
         /*properties.put("mail.smtp.port", 587);*/
        properties.put("mail.smtp.port",587);
        properties.put("mail.smtp.mail.sender", "sedetusqroo@gmail.com");
        properties.put("mail.smtp.password", "sedetus01");
        /* properties.put("mail.smtp.password", "veronica1972");*/
        properties.put("mail.smtp.user", "sedetusqroo@gmail.com");
        properties.put("mail.smtp.auth", "true");
        session = Session.getDefaultInstance(properties);
    }
    public boolean send(String destino,String asunto, String mensaje) {
        init();
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress((String) properties.get("mail.smtp.mail.sender")));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destino));
            message.setSubject(asunto);
            message.setContent(mensaje,"text/html");
            //message.setText("Texto");
            Transport t = session.getTransport("smtp");
            
            t.connect((String) properties.get("mail.smtp.user"), (String) properties.get("mail.smtp.password"));
            
            t.sendMessage(message, message.getAllRecipients());
            t.close();
            exito=true;
        } catch (MessagingException e) {
            
            return false;
        }
        return exito;
    }
    public boolean sendAcuse(String destino,String asunto, String mensaje,String adjun) {
        init();
        try {
            BodyPart texto = new MimeBodyPart();
            texto.setText(mensaje);
            
            BodyPart adjunto = new MimeBodyPart();
            adjunto.setDataHandler(
                new DataHandler(new FileDataSource(adjun)));
            adjunto.setFileName("Acuse.pdf");
            
            MimeMultipart multiParte = new MimeMultipart();
            
            multiParte.addBodyPart(texto);
            multiParte.addBodyPart(adjunto);
            
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress((String) properties.get("mail.smtp.mail.sender")));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destino));
            message.setSubject(asunto);
            message.setContent(multiParte,"text/html");
            //message.setContent(mensaje,"text/html");
            //message.setText("Texto");
            
            
            Transport t = session.getTransport("smtp");
            
            t.connect((String) properties.get("mail.smtp.user"), (String) properties.get("mail.smtp.password"));
            
            t.sendMessage(message, message.getAllRecipients());
            t.close();
            exito=true;
        } catch (MessagingException e) {
            
            return false;
        }
        return exito;
    }
}