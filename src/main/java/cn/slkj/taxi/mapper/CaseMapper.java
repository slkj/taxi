package cn.slkj.taxi.mapper;

import java.util.List;

import cn.slkj.taxi.util.PageData;

public interface CaseMapper {

	List<PageData> list(PageData pd);
	PageData listJbxx(PageData pd);
	
}
