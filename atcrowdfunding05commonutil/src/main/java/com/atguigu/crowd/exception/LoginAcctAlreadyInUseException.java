package com.atguigu.crowd.exception;

/**
 * 添加或更新用户时，账号重复异常
 * @author bingjiewang
 */
public class LoginAcctAlreadyInUseException extends RuntimeException{
    public LoginAcctAlreadyInUseException() {
        super();
    }

    public LoginAcctAlreadyInUseException(String message) {
        super(message);
    }

    public LoginAcctAlreadyInUseException(String message, Throwable cause) {
        super(message, cause);
    }

    public LoginAcctAlreadyInUseException(Throwable cause) {
        super(cause);
    }

    protected LoginAcctAlreadyInUseException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
