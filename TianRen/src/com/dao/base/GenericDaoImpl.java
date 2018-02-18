package com.dao.base;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;

import java.lang.reflect.Type;
import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.pojo.Movie;
import com.util.PageBean;

public class GenericDaoImpl<T, PK extends Serializable> extends
		HibernateDaoSupport implements IGenericDao<T, PK> {
	// ʵ��������(�ɹ��췽���Զ���ֵ)
	private Class<T> entityClass;

	// ���췽��������ʵ�����Զ���ȡʵ��������
	public GenericDaoImpl() {
		this.entityClass = null;
		Class c = getClass();
		Type t = c.getGenericSuperclass();
		if (t instanceof ParameterizedType) {
			Type[] p = ((ParameterizedType) t).getActualTypeArguments();
			this.entityClass = (Class<T>) p[0];
		}
	}

	// -------------------- �������������ӡ��޸ġ�ɾ������ --------------------
	// ����������ȡʵ�塣���û����Ӧ��ʵ�壬���� null��
	public T selectById(PK id) {
		return getHibernateTemplate().get(entityClass, id);
	}

	// ��ȡȫ��ʵ��
	public List<T> selectAll() {
		return (List<T>) getHibernateTemplate().loadAll(entityClass);
	}

	// �洢ʵ�嵽���ݿ�
	public void insert(T entity) {
		getHibernateTemplate().save(entity);
	}

	// ����ʵ��
	public void update(T entity) {
		getHibernateTemplate().update(entity);
	}

	// ɾ��ָ����ʵ��
	public void delete(T entity) {
		getHibernateTemplate().delete(entity);
	}

	// -------------------------------- Criteria ------------------------------

	// ������Ự�޹صļ�����׼
	public DetachedCriteria createDetachedCriteria() {
		return DetachedCriteria.forClass(this.entityClass);
	}

	// ������Ự�󶨵ļ�����׼
	public Criteria createCriteria() {
		return this.createDetachedCriteria().getExecutableCriteria(
				this.getSession());
	}

	// ʹ��ָ����ʵ�弰���Լ�������������������ԣ�ʵ��ֵ������
	// public List<T> selectEqualByEntity(T entity, String[] propertyNames) {
	// Criteria criteria = this.createCriteria();
	// Example exam = Example.create(entity);
	// exam.excludeZeroes();
	// String[] defPropertys = getSessionFactory().getClassMetadata(
	// entityClass).getPropertyNames();
	// for (String defProperty : defPropertys) {
	// int ii = 0;
	// for (ii = 0; ii < propertyNames.length; ++ii) {
	// if (defProperty.equals(propertyNames[ii])) {
	// criteria.addOrder(Order.asc(defProperty));
	// break;
	// }
	// }
	// if (ii == propertyNames.length) {
	// exam.excludeProperty(defProperty);
	// }
	// }
	// criteria.add(exam);
	// return (List<T>) criteria.list();
	// }

	// ʹ��ָ����ʵ�弰���Լ������������� like ��ʵ��ֵ������
	public PageBean selectLikeByEntityByPage(T entity, String[] propertyNames,int currentPage , int pageSize) {
		Criteria criteria = this.createCriteria();
		for (String property : propertyNames) {
			try {
				Object value = PropertyUtils.getProperty(entity, property);
				if (value instanceof String) {
					criteria.add(Restrictions.like(property, (String) value,
							MatchMode.ANYWHERE));
					criteria.addOrder(Order.asc(property));
				} 
//				else {
//					criteria.add(Restrictions.eq(property, value));
//					criteria.addOrder(Order.asc(property));
//				}
				criteria.setFirstResult((currentPage - 1) * pageSize);
				criteria.setMaxResults(pageSize);
			} catch (Exception ex) {
				// ������Ч�ļ����ο����ݡ�
			}
		}
		List<T> lstLikeEntity =(List<T>) criteria.list();
		
		Criteria criteria_totalRows = createCriteria();
		
		for (String property : propertyNames) {
			try {
				Object value = PropertyUtils.getProperty(entity, property);
				if (value instanceof String) {
					criteria_totalRows.add(Restrictions.like(property, (String) value,
							MatchMode.ANYWHERE));
				} 
			} catch (Exception ex) {
				// ������Ч�ļ����ο����ݡ�
			}
		}
		criteria_totalRows.setProjection(Projections.rowCount());
		
		int totalRows = Integer.parseInt(criteria_totalRows.uniqueResult()
				.toString());
		
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(totalRows);
		pageBean.setData(lstLikeEntity);

		return pageBean;
	}

	// ���ݸ���ģ�� ��ѯ�����ڸó־û����������
	public List<T> selectByExample(T entity) {
		Criteria criteria = this.createCriteria();
		criteria.add(Example.create(entity));
		return criteria.list();
	}
	
	//��ҳ
	public PageBean selectByPage( int currentPage , int pageSize  ){
		Criteria criteria_data=createCriteria();
		criteria_data.setFirstResult((currentPage - 1) * pageSize);
		criteria_data.setMaxResults(pageSize);
		
		List<T> entityClass=criteria_data.list();
		
		Criteria criteria_totalRows=createCriteria();
		criteria_totalRows.setProjection(Projections.rowCount());
		int totalRows=Integer.parseInt(criteria_totalRows.uniqueResult().toString());
		
		PageBean pageBean=new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(totalRows);
		pageBean.setData(entityClass);
		
		return pageBean;		
	}
}
