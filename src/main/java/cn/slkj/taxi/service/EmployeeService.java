/**
 * 
 */
package cn.slkj.taxi.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.taxi.entity.Employee;
import cn.slkj.taxi.mapper.EmployeeMapper;

/**
 * @author maxuh
 *
 */
@Service
@Transactional
public class EmployeeService {
	@Autowired
	private EmployeeMapper mapper;

	/**
	 * 查询分页数据
	 * 
	 * @param map
	 * @param pageBounds
	 * @return
	 */
	public List<Employee> listPage(HashMap<String, Object> map, PageBounds pageBounds) {
		return mapper.listPage(map, pageBounds);
	}

	/**
	 * 查询一条记录
	 * 
	 * @param hashMap
	 * @return
	 */
	public Employee selectOne(HashMap<String, Object> hashMap) {
		return mapper.selectOne(hashMap);
	}

	/**
	 * 根据id删除一条记录
	 * 
	 * @param id
	 * @return
	 */
	public int deleteById(String id) {
		return mapper.deleteById(id);
	}

	public List<Employee> slistPage(HashMap<String, Object> map, PageBounds pageBounds) {
		return mapper.slistPage(map, pageBounds);
	}

}
