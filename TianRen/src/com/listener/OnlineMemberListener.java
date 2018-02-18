package com.listener;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.pojo.Admin;
import com.pojo.Member;

public class OnlineMemberListener implements HttpSessionListener{

	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		
	}

	public void sessionDestroyed(HttpSessionEvent se) {
		HttpSession session = se.getSession();   
		ServletContext application = session.getServletContext();   
		
		// ȡ�õ�¼���û�
		if(session.getAttribute("curMember")!=null){
			List<Member> onlineMemberList = (List<Member>) application.getAttribute("onlineMemberList");
			Member curMember = (Member) session.getAttribute("curMember");   
			// �������б���ɾ���û�		   
			onlineMemberList.remove(curMember);   
			System.out.println("�û���"+curMember.getMemberEmail() + "��ʱ�˳���");   
		}
		if(session.getAttribute("curAdmin")!=null){
			List<Admin> onlineAdminList = (List<Admin>) application.getAttribute("onlineAdminList");
			Admin curAdmin = (Admin) session.getAttribute("curAdmin");   
			// �������б���ɾ������Ա		   
			onlineAdminList.remove(curAdmin);   
			System.out.println("����Ա��"+curAdmin.getAdminName() + "��ʱ�˳���");   
		}
	}

}
