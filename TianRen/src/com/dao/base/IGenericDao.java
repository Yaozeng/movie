package com.dao.base;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.util.PageBean;

public interface IGenericDao<T, PK extends Serializable> {

	// -------------------- �������������ӡ��޸ġ�ɾ������ --------------------

	// ����������ȡʵ�塣���û����Ӧ��ʵ�壬���� null��
	public abstract T selectById(PK id);

	// ��ȡȫ��ʵ��
	public abstract List<T> selectAll();

	// �洢ʵ�嵽���ݿ�
	public abstract void insert(T entity);

	// ����ʵ��
	public abstract void update(T entity);

	// ɾ��ָ����ʵ��
	public abstract void delete(T entity);

	// -------------------------------- Criteria ------------------------------

	// ������Ự�޹صļ�����׼����
	public DetachedCriteria createDetachedCriteria();

	// ������Ự�󶨵ļ�����׼����
	public Criteria createCriteria();

	// ʹ��ָ����ʵ�弰���Լ�������������������ԣ�ʵ��ֵ������
	//public List<T> selectEqualByEntity(T entity, String[] propertyNames);

	// ʹ��ָ����ʵ�弰����(������)�������������� like ��ʵ��ֵ������
	public PageBean selectLikeByEntityByPage(T entity, String[] propertyNames,int currentPage , int pageSize);
	
	//���ݸ���ģ��  ��ѯ�����ڸó־û����������
	public List<T> selectByExample(T entity);

	//��ҳ
	public PageBean selectByPage( int currentPage , int pageSize  );
}
