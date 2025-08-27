package com.bincui.colab.global.utils;

/**
 * 예외 처리와 관련된 유틸리티 메소드를 제공하는 클래스
 */

public final class ExceptionUtils {

    private ExceptionUtils() {
    }

    /**
     * 전달된 객체를 문자열로 변환한다.
     *
     * @param value 문자열로 변환할 객체
     * @return      {@code value}이 값이 {@code null}이라면 빈 문자열을, 그렇지 않다면 {@code value}의 {@code toString()}한 값을 반환
     */
    public static String nullSafeToString(Object value) {
        return value == null ? "" : value.toString();
    }

    /**
     * 제약 조건에 위반된 속성명을 반환한다.
     *
     * @param propertyPath  제약 조건이 위반된 속성 경로
     * @return              속성 경로에서 추출된 속성명 또는 속성 경로 그 자체를 반환
     */
    public static String violationField(String propertyPath) {
        int index = propertyPath.lastIndexOf('.');
        return index == -1 ? propertyPath : propertyPath.substring(index + 1);
    }
}
