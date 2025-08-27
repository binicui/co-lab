package com.bincui.colab.global.error;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {
    protected final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
}
