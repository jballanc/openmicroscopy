package ome.services.firehose;

import java.util.List;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;
import ome.model.meta.Event;
import ome.model.meta.EventLog;

/**
 * @author Joshua Ballanco, jballanc at glencoesoftware.com
 * @since 6.0
 */
public class EventFirehose
{
    private ConnectionFactory connectionFactory;
    private Destination destination;

    public ConnectionFactory getConnectionFactory()
    {
        return connectionFactory;
    }

    public void setConnectionFactory(ConnectionFactory connectionFactory)
    {
        this.connectionFactory = connectionFactory;
    }

    public Destination getDestination()
    {
        return destination;
    }

    public void setDestination(Destination destination)
    {
        this.destination = destination;
    }

    public void send(List<EventLog> logs)
    {
        for (EventLog l : logs) {
            send(l);
        }
    }

    public void send(EventLog log)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(log.getAction());
        sb.append(" ");
        sb.append(log);
        sb.append(log.getEntityType());
        sb.append(" ");
        sb.append(log.getEntityId());
        sb.append("\b");

        try
        {
            Connection conn = connectionFactory.createConnection();
            Session session = conn.createSession(false, Session.AUTO_ACKNOWLEDGE);
            MessageProducer producer = session.createProducer(destination);
            TextMessage message = session.createTextMessage(sb.toString());
            producer.send(message);
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
}

