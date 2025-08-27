package com.bincui.colab.global.config.security;

/**
 * 스프링 시큐리티 관련 상수를 정의한 상수 클래스
 */

public final class SecurityConstants {

    /**
     * 별도의 인증 없이 접근을 허용할 요청 URL
     */
    public static final String[] PUBLICY_REQUEST_MATCHERS = {
            /* 화면 요청 URL */
            "/",
            "/sign-up",
            /* API 요청 URL */
            "/api/v1/auth/login",
            "/api/v1/auth/logout",
            "/api/v1/user/exists/**",
            "/api/v1/user"
    };

    /**
     * 인증 검증 대상에서 제외되는 리소스 요청 URL
     */
    public static final String[] RESOURCE_MATCHERS = {
            "/favicon.ico",
            "/fonts/**",
            "/images/**",
            "/js/**",
            "/css/**",
            "/h2-console/**"
    };
}
