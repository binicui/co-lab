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

@Configuration
@EnableWebSecurity
public class WebSecurityConfig {

    /**
     * 비밀번호 암호화 처리를 수행하기 위한 {@link PasswordEncoder} 객체를 반환한다
     *
     * @return  해시 함수를 통해 비밀번호 암호화 처리하는 {@link BCryptPasswordEncoder}를 반환
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * 정적 자원에 대한 요청을 스프링 시큐리티 필터 적용에서 제외한다
     */
    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring().requestMatchers(SecurityConstants.PUBLIC_RESOURCES_MATCHERS);
    }

    /**
     * HTTP 요청에 대한 인증 및 인가를 담당한다
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        /* HTTP 기본 인증 비활성화 */
        http.httpBasic(basic -> basic.disable());
        /* 폼 기반 로그인 비활성화 */
        http.formLogin(form -> form.disable());
        /* CSRF(Cross-Site Request Forgery) 공격 방어 기능 비활성화 */
        http.csrf(csrf -> csrf.disable());
        /* H2 콘솔 접속을 위한 X-Frame-Option 헤더 설정 */
        http.headers(header -> header
                .frameOptions(HeadersConfigurer.FrameOptionsConfig::sameOrigin));
        /* HTTP 요청에 대한 인가 설정 */
        http.authorizeHttpRequests(auth -> auth
                .requestMatchers(SecurityConstants.PUBLIC_REQUEST_MATCHERS).permitAll()
                .anyRequest().authenticated());
        /* 세션 관리 정책 */
        http.sessionManagement(session -> session
                .maximumSessions(1)     // 최대 허용 가능 세션 수
                .maxSessionsPreventsLogin(true));   // 동시 로그인 차단
        return http.build();
    }
}