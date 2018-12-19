package cn.slkj.taxi.mapper;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import cn.slkj.taxi.entity.Enterprise;
import cn.slkj.taxi.util.PageData;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;



/**
 * 公司 / 平台分组 dao
 */
@Repository
public interface EnterpriseMapper {

	/**
	 * 查询公司/车队列表
	 * 
	 * @param map
	 * @return
	 */
	List<Enterprise> queryComList(PageData pd);

	/**
	 * 查询公司/车队列表
	 * 
	 * @param map
	 * @param pageBounds
	 * @return
	 */

	List<Enterprise> queryList(PageData pd, PageBounds pageBounds);

	/**
	 * 查询公司/车队总记录数
	 * 
	 * @param map
	 * @return
	 */
	//int queryListCount(PageData pd);

	/**
	 * 添加公司/车队
	 * 
	 */
	int save(PageData pd);

	/**
	 * 编辑公司/车队
	 * 
	 * @param Agent
	 */
	int edit(PageData pd);

	/**
	 * 根据ids批量删除公司/车队记录
	 * 
	 * @param id
	 */

	int delete(String id);

	/**
	 * 根据id查询公司信息
	 * 
	 * @param id
	 * @return
	 */
	Enterprise queryOne(String id);

}