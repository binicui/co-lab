package com.bincui.colab.global.config.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
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
@Order(1)
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring().requestMatchers(SecurityConstants.RESOURCE_MATCHERS);
    }

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
                .requestMatchers(SecurityConstants.PUBLIC_REQUEST_MATCHERS).permitAll()
                .anyRequest().authenticated());
        /* 세션 관리 정책 설정 */
        http.sessionManagement(session -> session
                .maximumSessions(1)
                .maxSessionsPreventsLogin(false)
                .expiredUrl("/login"));
        return http.build();
    }
}