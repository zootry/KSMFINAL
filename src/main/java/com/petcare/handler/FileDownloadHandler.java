package com.petcare.handler;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import com.petcare.domain.Path;

import lombok.extern.log4j.Log4j;

@Log4j
public class FileDownloadHandler extends AbstractView {
	public FileDownloadHandler() {
		setContentType("application/octet-stream; charset=utf-8");
	}
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		File file = (File)model.get("downloadFile");
		
		response.setContentType(getContentType());
		response.setContentLength((int)file.length());
		String ofname = request.getParameter("ofname");
		String value = "attachment; filename="+java.net.URLEncoder.encode(ofname, "utf-8")+";";
		System.out.println("원본이름 테스트: "+ofname);
		response.setHeader("Content-Disposition", value);
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		FileInputStream fis = null;
		OutputStream os = response.getOutputStream();
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, os);
			os.flush();
		}catch(IOException ie) {
			log.info("#FileDownloadhandler Exception: "+ ie);
		}finally {
			if(fis != null) fis.close();
			if(os != null) os.close();
		}
		
	}
}
