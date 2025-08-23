package com.bincui.colab.global.config.security;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

/**
 * 스프링 시큐리티 관련 상수를 정의한 상수 클래스
 */

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class SecurityConstants {

    /**
     * 별도의 인증 없이 접근을 허용할 요청 URL들을 정의한 문자열 타입의 상수 배열
     */
    public static String[] PUBLIC_REQUEST_MATCHERS = {
            "/",
            "/sign-up",
            "/api/v1/auth/login",
            "/api/v1/auth/logout",
            "/api/v1/user/exists/*",
            "/api/v1/user"
    };

    /**
     * 인증 검증 대상에서 제외될 정적 리소스의 경로들을 정의한 문자열 타입의 상수 배열
     */
    public static String[] PUBLIC_RESOURCES_MATCHERS = {
            "/css/**",
            "/fonts/**",
            "/images/**",
            "/js/**",
            "/favicon.ico",
            "/h2-console"
    };
}
