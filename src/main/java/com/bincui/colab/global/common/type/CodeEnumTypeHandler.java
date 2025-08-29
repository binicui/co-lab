package com.bincui.colab.global.common.type;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedTypes;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * {@link CodeEnum}을 구현한 열거형 내의 문자열 타입 코드값과 데이터베이스 컬럼 간의 매핑을 통해 코드값을
 * 데이터베이스에 저장하거나 데이터베이스로부터 읽어온 코드값을 열거형으로 변환하는 작업을 수행하는 타입 핸들러
 *
 * @param <E> 타입 핸들러에서 처리하고자 하는 열거형
 */

@MappedTypes(CodeEnum.class)
public class CodeEnumTypeHandler<E extends Enum<E> & CodeEnum> extends BaseTypeHandler<E> {

    private final Class<E> type;

    private final E[] enums;

    public CodeEnumTypeHandler(Class<E> type) {
        if (type == null) {
            throw new IllegalArgumentException("Type argument cannot be null.");
        }
        this.type = type;
        this.enums = type.getEnumConstants();
        if (!type.isInterface() && this.enums == null) {
            throw new IllegalArgumentException(type.getSimpleName() + " does not represent an enum type.");
        }
    }

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, E parameter, JdbcType jdbcType) throws SQLException {
        ps.setString(i, parameter.getCode());
    }

    @Override
    public E getNullableResult(ResultSet rs, String columnName) throws SQLException {
        return fromCode(rs.getString(columnName));
    }

    @Override
    public E getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        return fromCode(rs.getString(columnIndex));
    }

    @Override
    public E getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        return fromCode(cs.getString(columnIndex));
    }

    /**
     * 데이터베이스로부터 읽어온 코드값과 매치되는 값을 가진 열거형의 상수를 반환한다.
     *
     * @param code  데이터베이스로부터 조회해온 코드값
     * @return      코드값과 일치하는 값이 존재할 경우 그 값이 저장된 상수를 반환
     */
    private E fromCode(String code) {
        for (E constant : enums) {
            if (constant.getCode().equals(code)) {
                return constant;
            }
        }
        throw new IllegalArgumentException("Cannot convert " + code + " to " + type.getSimpleName());
    }
}