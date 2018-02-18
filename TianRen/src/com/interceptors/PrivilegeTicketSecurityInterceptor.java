package com.interceptors;

import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import com.pojo.Admin;

public class PrivilegeTicketSecurityInterceptor extends MethodFilterInterceptor{
	private String name;
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	@Override
	public void init() {
		super.init();
		System.out.println("Ʊ�����Ȩ�ް�ȫ������"+name+"��ʼ���ˣ�");
	}

	@Override
	public void destroy() {
		super.destroy();
		System.out.println("Ʊ�����Ȩ�ް�ȫ������"+name+"�����ˣ�");
	}
	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		System.out.println("���ι���Ȩ�ް�ȫ������"+name+"�����ˣ�");
		Map<String, Object> session = invocation.getInvocationContext()
				.getSession();
		if (session.get("curAdmin") != null) {
			if(((Admin)session.get("curAdmin")).getAdminPrivilege().indexOf("4")!=-1){
				return invocation.invoke();
			}else{
				return "adminLogin";
			}
		} else {
			return "adminLogin";
		}
	}

}
