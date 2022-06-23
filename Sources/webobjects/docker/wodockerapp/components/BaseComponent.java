package webobjects.docker.wodockerapp.components;

import com.webobjects.appserver.WOContext;

import er.extensions.components.ERXComponent;

import webobjects.docker.wodockerapp.Application;
import webobjects.docker.wodockerapp.Session;

public class BaseComponent extends ERXComponent {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public BaseComponent(WOContext context) {
		super(context);
	}
	
	@Override
	public Application application() {
		return (Application)super.application();
	}
	
	@Override
	public Session session() {
		return (Session)super.session();
	}
}
