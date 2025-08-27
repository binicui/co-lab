package com.bincui.colab.global.common.response;

import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Collections;
import java.util.List;

/**
 * {@code @RestController} 클래스의 응답 본문을 가로채 {@link ApiResponse} 형식으로 래핑 및 반환하는 클래스
 */

@RestControllerAdvice(basePackages = "com.bincui.colab.domain")
public class ApiResponseBodyAdvice implements ResponseBodyAdvice<Object> {

    /**
     * 반환 타입이 {@link org.springframework.http.ResponseEntity}일 경우 처리 대상으로 간주하여 {@code beforeBodyWrite()}를 실행한다.
     *
     * @param returnType    메소드의 반환 타입 정보
     * @param converterType 선택된 컨버터 타입
     * @return              {@link org.springframework.http.ResponseEntity}일 경우 {@code true}, 아닐 경우 {@code false}를 반환
     */
    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        return ResponseEntity.class.isAssignableFrom(returnType.getParameterType());
    }

    /**
     * 컨트롤러 클래스의 반환값을 {@link ApiResponse}로 래핑하여 클라이언트에게 반환한다. 이때, 응답 본문의 {@code data}가 {@code null}일 경우,
     * 그 값의 유형에 따라 빈 리스트([]) 또는 빈 맵({})을 할당한다.
     *
     * @param body                      컨트롤러 클래스에서 반환된 응답 결과 데이터
     * @param returnType                메소드의 반환 타입 정보
     * @param selectedContentType       선택된 미디어 타입
     * @param selectedConverterType     선택된 컨버터 타입
     * @param request                   요청 정보 객체
     * @param response                  응답 정보 객체
     * @return                          {@link ApiResponse} 객체
     */
    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType,
                                  Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request,
                                  ServerHttpResponse response) {
        /* ResponseEntity 및 ResponseEntity의 제네릭 타입 정보(ResponseEntity<?>)를 포함하여 가져온다. */
        Type genericType = returnType.getGenericParameterType();
        /* ResponseEntity가 갖고 있던 제네릭 타입 정보(< > 안의 타입 정보)를 가져온다. */
        Type actualType = (genericType instanceof ParameterizedType)    
                            ? ((ParameterizedType) genericType).getActualTypeArguments()[0]
                            : genericType;
        Object payload = (body == null) ? emptyPayload(actualType) : body;
        return ApiResponse.ok(payload);
    }

    /**
     * 실제 반환 타입에 맞는 빈 페이로드를 반환한다.
     *
     * @param actualType    컨트롤러 클래스의 {@link org.springframework.http.ResponseEntity}에 담긴 실제 값의 타입
     * @return              {@code actualType}의 타입이 {@link java.util.List}일 경우 빈 리스트([])를, 그 외 타입이면 빈 맵({})을 반환
     */
    private Object emptyPayload(Type actualType) {
        Type rawType = (actualType instanceof ParameterizedType)
                        ? ((ParameterizedType) actualType).getRawType()
                        : actualType;
        if (rawType instanceof Class<?>) {
            Class<?> clazz = (Class<?>) rawType;
            if (List.class.isAssignableFrom(clazz)) {
                return Collections.emptyList();
            }
        }
        return Collections.emptyMap();
    }
}
