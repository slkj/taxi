/**
 * 
 */
package cn.slkj.taxi.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.slkj.taxi.entity.EmployeeContinueRegister;
import cn.slkj.taxi.mapper.EmployeeContinueRegisterMapper;
import cn.slkj.taxi.util.PageData;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

/**
 * 
 * @ClassName:  EmployeeRegisterService   
 * @Description:注册类业务   
 * @author: wangling 
 * @date:   2018年12月8日 上午9:28:42   
 *
 */
@Service
@Transactional
public class EmployeeContinueRegisterService {
	@Autowired
	private EmployeeContinueRegisterMapper mapper;

	/**
	 * 查询分页数据
	 * 
	 * @param map
	 * @param pageBounds
	 * @return
	 */
	public List<EmployeeContinueRegister> list(PageData pd, PageBounds pageBounds) {
		return mapper.list(pd, pageBounds);
	}

	/**
	 * 查询一条记录
	 * 
	 * @param hashMap
	 * @return
	 */
	public EmployeeContinueRegister selectById(HashMap<String, Object> hashMap) {
		return mapper.selectById(hashMap);
	}

	
	public int insert(PageData pd) {
		return mapper.insert(pd);
	}

	public int update(PageData pd) {
		return mapper.update(pd);
	}
	
	/**
	 * 根据id删除一条记录
	 * 
	 * @param id
	 * @return
	 */
	public int delete(String id) {
		return mapper.delete(id);
	}


	public int updateStatus(PageData pd) {
		return mapper.updateStatus(pd);
	}
}
