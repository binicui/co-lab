package com.bincui.colab.global.config.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

/**
 * 스프링 시큐리티 설정 클래스
 */

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    /**
     * 비밀번호 암호화 처리 객체 스프링 빈 등록한다.
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * 정적 자원 요청을 시큐리티 필터 적용에서 제외한다.
     */
    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring().requestMatchers(SecurityConstants.RESOURCE_MATCHERS);
    }

    /**
     * HTTP 요청에 대한 인증 및 인가 등의 보안 관련 정책을 설정한다.
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        /* HTTP 기본 인증, 폼 기반 로그인, CSRF 공격 방어 기능 등 비활성화 */
        http.httpBasic(basic -> basic.disable())
            .formLogin(form -> form.disable())
            .csrf(csrf -> csrf.disable());
        /* H2 콘솔 접속을 위한 X-Frame-Option 헤더 설정 */
        http.headers(header -> header
                .frameOptions(HeadersConfigurer.FrameOptionsConfig::sameOrigin));
        /* HTTP 요청 인가 설정 */
        http.authorizeHttpRequests(auth -> auth
                .requestMatchers(SecurityConstants.PUBLICY_REQUEST_MATCHERS).permitAll()
                .anyRequest().authenticated());
        /* 세션 관리 정책 설정 */
        http.sessionManagement(session -> session
                .maximumSessions(1)                 // 최대 허용 가능한 세션 수 (-1: 무제한)
                .maxSessionsPreventsLogin(false)    // 동시 로그인 차단 (false : 기존 세션 만료, true : 인증 실패 처리)
                .expiredUrl("/login"));             // 세션 만료시 이동할 페이지
        return http.build();
    }
}
