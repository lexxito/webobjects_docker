package webobjects.docker.components;

import java.net.InetAddress;
import java.net.UnknownHostException;

import com.webobjects.appserver.WOContext;

public class Main extends BaseComponent {
	public Main(WOContext context) {
		super(context);
	}
	
	public String instanceId() throws UnknownHostException {
      return InetAddress.getLocalHost().getHostName();
    }
}
