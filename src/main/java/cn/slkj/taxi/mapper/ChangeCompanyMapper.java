package cn.slkj.taxi.mapper;

import java.util.HashMap;
import java.util.List;

import cn.slkj.taxi.entity.ChangeCompany;
import cn.slkj.taxi.util.PageData;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

/**
 * 公司更换
 */
public interface ChangeCompanyMapper {
	/**
	 * 查询分页数据
	 * 
	 * @param map
	 * @param pageBounds
	 * @return
	 */
	List<ChangeCompany> list(PageData pd, PageBounds pageBounds);

	ChangeCompany selectOne(HashMap<String, Object> hashMap);

	int delete(String id);

	int insert(PageData pd);

	int update(PageData pd);
	
	
}
