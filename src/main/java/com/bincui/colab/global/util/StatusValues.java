package com.bincui.colab.global.util;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.Arrays;

/**
 * 프로젝트 전반에서 사용될 상태값(사용 여부, 삭제 여부 등)의 처리를 위해 서로 다른 타입의 데이터들을 상응되는 의미별로 정의 및 관리하기 위한 열거형
 */

@RequiredArgsConstructor
@Getter
public enum StatusValues {

    YES (1, "Y", true),
    NO (0, "N", false);

    private final int numeric;

    private final String character;

    private final boolean flag;

    /**
     * 주어진 정수값을 논리형 상태값으로 변환한다.
     *
     * @param value 논리형 상태값으로 변환할 정수값
     * @return      {@code value}가 {@code 1}일 경우 {@code true}, {@code 0}일 경우 {@code false}를 반환
     */
    public static boolean valueOf(int value) {
        return Arrays.stream(values())
                .filter(e -> e.getNumeric() == value)
                .findFirst()
                .map(StatusValues::isFlag)
                .orElseThrow(() -> new IllegalArgumentException("Cannot convert " + value + " to boolean type."));
    }
}