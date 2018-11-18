/**
 * 
 */
package cn.slkj.taxi.controller.standard;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.slkj.taxi.controller.base.BaseController;

/**
 * 
 * 诚信考核
 * 
 * @author maxuh
 *
 */

@Controller
@RequestMapping({ "/standard" })
public class StandardController extends BaseController {

	// 人员信息页面
	@RequestMapping("/standardListPage")
	public String employeeListPage() {
		return "standard/standard";
	}

}
