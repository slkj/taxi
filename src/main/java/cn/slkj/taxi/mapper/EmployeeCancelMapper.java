package cn.slkj.taxi.mapper;

import java.util.HashMap;
import java.util.List;

import cn.slkj.taxi.entity.EmployeeCancel;
import cn.slkj.taxi.util.PageData;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

/**
 * 公司更换
 */
public interface EmployeeCancelMapper {
	/**
	 * 查询分页数据
	 * 
	 * @param map
	 * @param pageBounds
	 * @return
	 */
	List<EmployeeCancel> list(HashMap<String, Object> map, PageBounds pageBounds);

	EmployeeCancel selectOne(HashMap<String, Object> hashMap);

	int delete(String id);

	int insert(PageData pd);

	int update(PageData pd);
	
	
}
