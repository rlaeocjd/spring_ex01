package com.spring.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

import com.spring.mimeMediaUtil.MediaUtils;

public class UploadFileUtils {
	private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);
	
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
		UUID uid = UUID.randomUUID();
		
		String savedName = uid.toString() + "_" + originalName;
		String savedPath = calcPath(uploadPath);
		
		File target = new File(uploadPath + savedPath, savedName);
		FileCopyUtils.copy(fileData, target);
		
		String formatName = originalName.substring(originalName.lastIndexOf(".") + 1);
		String uploadFileName = null;
		
		if(MediaUtils.getMediaType(formatName) != null) {
			uploadFileName = makeThumbnail(uploadPath, savedPath, savedName);
		} else {
			uploadFileName = makeIcon(uploadPath, savedPath, savedName); 
		}
		
		return uploadFileName;
	}
	 private static String makeIcon(String uploadPath, String path, String fileName) throws Exception {
		 String iconName = uploadPath + path + File.separator + fileName;
		 return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	 }
	
	
	// 날짜를 가지고 폴더명 생성
	private static String calcPath(String uploadPath){
		Calendar cal = Calendar.getInstance();
		
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		
		String monthPath = yearPath + 
				File.separator + 
				new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		
		String datePath = monthPath + 
				File.separator + 
				new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		makeDir(uploadPath, yearPath, monthPath, datePath);
		
		return datePath;
	}
	
	// 디렉토리 생성
	private static void makeDir(String uploadPath, String... paths){
		if(new File(paths[paths.length - 1]).exists()){
			return;
		}
		
		for (String path : paths) {
			File dirPath = new File(uploadPath + path);
			
			if(! dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
	
	// 썸네일용 이미지 생성
	private static String makeThumbnail(String uploadPath, String path, String fileName) throws Exception{
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));
		
		BufferedImage destImg = Scalr.resize(sourceImg, 
				Scalr.Method.AUTOMATIC, 
				Scalr.Mode.FIT_TO_HEIGHT, 100);
		
		String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;
		
		File newFile = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
}