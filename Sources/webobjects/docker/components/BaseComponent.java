package webobjects.docker.components;

import com.webobjects.appserver.WOContext;

import er.extensions.components.ERXComponent;

import webobjects.docker.Application;
import webobjects.docker.Session;

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
