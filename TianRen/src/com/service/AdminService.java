package com.service;

import java.util.List;

import com.dao.AdminDao;
import com.pojo.Admin;
import com.util.PageBean;

public class AdminService {
	
	private AdminDao adminDao;

	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	/**
	 * ����Ա��¼
	 * @param admin
	 * @return
	 */
	public Admin login(Admin admin){
		List<Admin> lstAdmin=adminDao.selectByExample(admin);
		if(lstAdmin.size()==0){
			return null;
		}else{
			return lstAdmin.get(0);
		}		
	}	
	
	/**
	 * ��ѯ���й���Ա
	 * @return
	 */
	public List<Admin> findAll(){
		return adminDao.selectAll();
	}
	
	/**
	 * ��ӹ���Ա
	 * @param admin
	 */
	public void create(Admin admin){
		adminDao.insert(admin);
	}
	
	/**
	 * ���ݵ�¼����ѯ
	 * @param adminName
	 * @return
	 */
	public boolean findByName(String adminName){
		Admin admin=new Admin();
		admin.setAdminName(adminName);
		List<Admin> lstAdmin=adminDao.selectByExample(admin);
		if(lstAdmin.size()>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * ����ID�����Ա
	 * @param admin
	 * @return
	 */
	public Admin findById(Admin admin){
		return adminDao.selectById(admin.getAdminId());
	}
	
	/**
	 * �޸Ĺ���Ա
	 * @param admin
	 */
	public void modifyAdmin(Admin admin){
		adminDao.update(admin);
	}
	
	/**
	 * ɾ������Ա
	 * @param admin
	 */
	public void remove(Admin admin){
		adminDao.delete(adminDao.selectById(admin.getAdminId()));
	}
}
