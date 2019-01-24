package cn.slkj.taxi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.slkj.taxi.mapper.CaseMapper;
import cn.slkj.taxi.util.PageData;

@Service
@Transactional
public class CaseService {
	@Autowired
	private CaseMapper mapper;

	public List<PageData> list(PageData pd) {
		return mapper.list(pd);
	}

	public PageData listJbxx(PageData pd) {
		return mapper.listJbxx(pd);
	}

}
