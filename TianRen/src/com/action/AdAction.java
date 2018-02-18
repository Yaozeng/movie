package com.action;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pojo.Ad;
import com.service.AdService;
import com.util.FileProcessUitl;

public class AdAction extends ActionSupport implements ModelDriven<Ad>{

	private Ad ad=new Ad();
	
	public Ad getModel() {
		// TODO Auto-generated method stub
		return ad;
	}
	
	private AdService adService=new AdService();

	public void setAdService(AdService adService) {
		this.adService = adService;
	}
	
	private File[] upload; // �����ϴ����ļ����� ---> ͼƬA���� ͼƬB����
	private String[] uploadContentType; // �����ļ����� ---> png jpg
	private String[] uploadFileName; // �����ļ��� ---> A.PNG B.jpg

	public File[] getUpload() {
		return upload;
	}

	public void setUpload(File[] upload) {
		this.upload = upload;
	}

	public String[] getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String[] uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public String[] getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String[] uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	
	/**
	 * ��ѯ���ù��
	 * @return
	 * @throws Exception
	 */
	public String findAllAd() throws Exception{
		Map<String,Object> application=ActionContext.getContext().getApplication();
		List<Ad> lstAd= adService.findAll();
		application.put("lstAd", lstAd);
		return "updateAd";
	}
	
	/**
	 * �޸Ĺ��
	 * @return
	 * @throws Exception
	 */
	public String modifyAd() throws Exception{
		FileProcessUitl util = new FileProcessUitl();
		String path = util.processFileUpload("/uploadAd", upload, uploadFileName);
		ad.setAdImg(path);
		adService.modify(ad);
		
		return findAllAd();
	}

}
