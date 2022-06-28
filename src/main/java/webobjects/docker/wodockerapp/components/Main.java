package webobjects.docker.wodockerapp.components;

import java.net.InetAddress;
import java.net.UnknownHostException;

import com.webobjects.appserver.WOContext;

public class Main extends BaseComponent {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public Main(WOContext context) {
		super(context);
	}
	
	public String instanceId() throws UnknownHostException {
		return InetAddress.getLocalHost().getHostName();
    }
}
