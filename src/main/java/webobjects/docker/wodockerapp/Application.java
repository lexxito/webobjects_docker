package webobjects.docker.wodockerapp;

import er.extensions.appserver.ERXApplication;
import er.extensions.foundation.ERXConfigurationManager;

public class Application extends ERXApplication {
	
	static {
		ERXConfigurationManager.defaultManager().setCommandLineArguments( new String[0] );
	}

	public static void main(String[] argv) {
		ERXApplication.main(argv, Application.class);
	}

	public Application() {
		ERXApplication.log.info("Welcome to " + name() + " !");
		/* ** put your initialization code in here ** */
		setAllowsConcurrentRequestHandling(true);		
	}
}
