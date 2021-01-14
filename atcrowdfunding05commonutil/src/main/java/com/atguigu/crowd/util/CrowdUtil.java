package com.atguigu.crowd.util;

import java.io.*;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import com.atguigu.crowd.constant.CrowdConstant;
import org.apache.log4j.Logger;
import org.apache.log4j.spi.LoggerFactory;

/**
 * 尚筹网项目通用工具方法类
 *
 * @author
 */
public class CrowdUtil {

    private static Logger logger = Logger.getLogger(CrowdUtil.class);

    /**
     * 对明文字符串进行MD5加密
     *
     * @param source 传入的明文字符串
     * @return 加密结果
     */
    public static String md5(String source) {

        // 1.判断source是否有效
        if (source == null || source.length() == 0) {

            // 2.如果不是有效的字符串抛出异常
            throw new RuntimeException(CrowdConstant.MESSAGE_STRING_INVALIDATE);
        }

        try {
            // 3.获取MessageDigest对象
            String algorithm = "md5";

            MessageDigest messageDigest = MessageDigest.getInstance(algorithm);

            // 4.获取明文字符串对应的字节数组
            byte[] input = source.getBytes();

            // 5.执行加密
            byte[] output = messageDigest.digest(input);

            // 6.创建BigInteger对象
            int signum = 1;
            BigInteger bigInteger = new BigInteger(signum, output);

            // 7.按照16进制将bigInteger的值转换为字符串
            int radix = 16;
            String encoded = bigInteger.toString(radix).toUpperCase();

            return encoded;

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * 判断当前请求是否为Ajax请求
     *
     * @param request 请求对象
     * @return true：当前请求是Ajax请求
     * false：当前请求不是Ajax请求
     */
    public static boolean judgeRequestType(HttpServletRequest request) {

        // 1.获取请求消息头
        String acceptHeader = request.getHeader("Accept");
        String xRequestHeader = request.getHeader("X-Requested-With");

        // 2.判断
        return (acceptHeader != null && acceptHeader.contains("application/json"))
                || (xRequestHeader != null && "XMLHttpRequest".equals(xRequestHeader));
    }

    /**
     * 模拟短信发送
     *
     * @param phone   电话号码，如：12345678910
     * @param context 业务内容，如：用户注册
     * @return
     */
    public static ResultEntity<String> sendShortMessage(String phone, String context) {

        if (phone.length() == 11) {
            //生成6为随机验证嘛
            Random random = new Random();
            StringBuilder stringBuilder = new StringBuilder();
            for (int i = 0; i < 6; i++) {
                int randomInt = random.nextInt(10);
                stringBuilder.append(randomInt);
            }
            String data = stringBuilder.toString();
            logger.debug("【" + context + "】=>手机号码：【" + phone + "】=>验证码：【" + data + "】");
            return ResultEntity.successWithData(data);
        } else {
            logger.debug("【" + context + "】=>手机号码：【" + phone + "】=>发送失败：【手机号码不是11位,发送失败】");
            return ResultEntity.failed("手机号码不是11位,发送失败");
        }
    }

    /**
     * 自定义文件上传
     *
     * @param path
     * @param serverFilesPath
     * @return
     */
    public static ResultEntity<String> uploadFile(String path, String serverFilesPath) {

        FileInputStream fileInputStream = null;
        try {
            fileInputStream = new FileInputStream(path);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return ResultEntity.failed(e.getMessage());
        }

        //用当前年月份作为子文件夹
        Date date = new Date(System.currentTimeMillis());
        String dirName = new SimpleDateFormat("yyyyMMdd").format(date);

        //目标文件
        String suffix = path.substring(path.lastIndexOf("."));
        String serverFileName = UUID.randomUUID().toString().replace("-", "");
        String realDirName = serverFilesPath + File.separator + dirName;
        String targetFileName = serverFileName + suffix;

        //创建目标文件夹
        File targetDir = new File(realDirName);
        if (!targetDir.exists()) {
            targetDir.mkdirs();
        }

        File targetFile = new File(targetDir, targetFileName);
        OutputStream outputStream = null;
        try {
            outputStream = new FileOutputStream(targetFile);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return ResultEntity.failed(e.getMessage());
        }
        byte[] bytes = new byte[1024];

        try {
            int i = 0;
            while ((i = fileInputStream.read(bytes)) > 0) {
                outputStream.write(bytes, 0, i);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return ResultEntity.failed(e.getMessage());
        }
        return ResultEntity.successWithData(targetFile.getAbsolutePath());
    }

/*	public static void main(String[] args) {
		System.out.println(uploadFile("C:\\Users\\binjiewang\\Desktop\\QQ截图20210113082028.png","E:\\FundUploadFiles"));
	}*/

}
