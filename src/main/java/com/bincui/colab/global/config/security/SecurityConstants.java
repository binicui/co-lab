package com.bincui.colab.global.config.security;

/**
 * 스프링 시큐리티 설정 관련 상수를 정의한 상수 클래스
 */

public final class SecurityConstants {

    /**
     * 별도의 인증 요구 없이 액세스를 허용할 요청 URL
     */
    public static final String[] PUBLIC_REQUEST_MATCHERS = {
            /* 페이지 요청 URL */
            "/",
            "/sign-up",
            /* API 요청 URL */
            "/api/v1/auth/login",
            "/api/v1/auth/logout",
            "/api/v1/user/exists/**",
            "/api/v1/user"
    };

    /**
     * 스프링 시큐리티 필터 적용에서 제외시킬 리소스 요청 URL
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