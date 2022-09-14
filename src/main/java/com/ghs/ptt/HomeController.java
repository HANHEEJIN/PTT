package com.ghs.ptt;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;



import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		logger.info("Welcome home!");
		
		return "home";
	}
	
	
	// jsp이동
	// dashboard.jsp 이동
	@GetMapping(value = "/dashBoard")
	public String dashBoard() {
		return "dashBoard";
	}
	
	
	// jsp이동
	// dashboard.jsp 이동
	@GetMapping(value = "/dashBoardGuest")
	public String dashBoardGuest() {
		return "dashBoardGuest";
	}
	
	
	
		
	
	@GetMapping("admin")
    public String admin() {
        return "admin";
    }
	
	
	// jsp이동
	// dashboard.jsp 이동
	@GetMapping(value = "/aes")
	public String aes() {
		return "aes";
	}
	
	
	@RequestMapping("/divice")
    public @ResponseBody String detectDevice(HttpServletRequest request) {        
		Device device = DeviceUtils.getCurrentDevice(request);        
		if (device == null) {
			return "device is null";
        }
        String deviceType = "unknown";
        if (device.isNormal()) {
            deviceType = "nomal";
        } else if (device.isMobile()) {
            deviceType = "mobile";
        } else if (device.isTablet()) {
            deviceType = "tablet";
        }
        return "Hello " + deviceType + " browser!";
	
	}
	
}
