package webobjects.docker.wodockerapp;

import er.extensions.appserver.ERXSession;

public class Session extends ERXSession {
	private static final long serialVersionUID = 1L;

	public Session() {
		setStoresIDsInCookies(true);
		setStoresIDsInURLs(false);
	}
	
	@Override
	public Application application() {
		return (Application)super.application();
	}
	
}
