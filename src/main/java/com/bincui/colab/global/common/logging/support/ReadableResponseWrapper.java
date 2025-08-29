package com.bincui.colab.global.common.logging.support;

import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.util.ContentCachingResponseWrapper;

/**
 * HTTP 응답 본문을 캐싱 처리하여 여러 번 읽기 위한 응답 본문 래퍼 클래스
 */

public class ReadableResponseWrapper extends ContentCachingResponseWrapper {

    /**
     * 전달된 서블릿 응답을 위한 새로운 {@link ContentCachingResponseWrapper}를 생성한다.
     *
     * @param response 원본의 서블릿 응답
     */
    public ReadableResponseWrapper(HttpServletResponse response) {
        super(response);
    }
}