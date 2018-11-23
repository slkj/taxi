package cn.slkj.taxi.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.taxi.entity.Examine;
import cn.slkj.taxi.entity.ExamineStandard;
import cn.slkj.taxi.mapper.ExamineMapper;

/*
 * 
 */
@Service
public class ExamineService {
	@Autowired
	private ExamineMapper examineMapper;

	public List<Examine> getExamineList(HashMap<String, Object> map, PageBounds pageBounds) {
		return examineMapper.getExamineList(map, pageBounds);
	}

	public List<ExamineStandard> getStandardList() {
		return examineMapper.getStandardList();
	}
}
