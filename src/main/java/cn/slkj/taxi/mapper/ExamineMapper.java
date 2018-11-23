package cn.slkj.taxi.mapper;

import java.util.HashMap;
import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.taxi.entity.Examine;
import cn.slkj.taxi.entity.ExamineStandard;

/**
 *  
 */
public interface ExamineMapper {
	 
	List<Examine> getExamineList(HashMap<String, Object> map, PageBounds pageBounds);
	List<ExamineStandard> getStandardList();
	
}
