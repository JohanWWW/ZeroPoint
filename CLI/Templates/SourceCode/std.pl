﻿
//
//
print = native (obj) => <@"std.print">;

//
//
println = native (obj) => <@"std.println">;

//
//
readln = native () => <@"std.readln">;

//
//
number = native (s) => <@"std.number">;

//
//
delay = native (millis) => <@"std.delay">;

//
//
Array = (size) => {
    // Internal use only
    __array_allocate = native (s) => <@"std.Array.__array_allocate">;
    __array_length = native (ref) => <@"std.Array.__array_length">;
    __array_get = native (ref, index) => <@"std.Array.__array_get">;
    __array_set = native (ref, index, value) => <@"std.Array.__array_set">;

    _array = __array_allocate(size);
    _length = __array_length(_array);

    _get = (index) => {
        return __array_get(_array, index);
    };

    _set = (index, value) => {
        return __array_set(_array, index, value);
    };

    _Enumerator = () => {
        // TODO: Unary operator '-' is not supported at the moment
        // The workaround is representing a negative number with (0 - x)
        i = 0 - 1;

        return {
            next = () => {
                hasNext = null;
                if (i >= _length - 1) {
                    hasNext = false;
                }
                else {
                    i = i + 1;
                    hasNext = true;
                }
                return hasNext;
            },
            current = () => {
                return _get(i);
            }
        };
    };

    _enumerator = () => {
        return _Enumerator();
    };

    return {
        length = _length,
        get = _get,
        set = _set,
        enumerator = _enumerator
    };
};

// ArrayList implementation.
// TODO: Implement insertAt method
//
ArrayList = (size) => {
    _array = null;
    _length = 0;

    // Allocate array
    if (size == null) {
        _array = Array(10);
    }
    else {
        _array = Array(size);
    }

    _increase_size = (increment) => {
        tmp = Array(_length + increment);
        _copy_array(_array, tmp);
        _array = tmp;
    };

    _decrease_size = (decrement) => {
        tmp = Array(_length - decrement);
        _copy_array(_array, tmp);
        _array = tmp;
    };

    _copy_array = (src, dst) => {
        i = 0;
        while (i < src.length) {
            dst.set(i, src.get(i));
            i = i + 1;
        }
    };

    _Enumerator = () => {
        i = 0 - 1;

        _next = () => {
            hasNext = null;
            if (i >= _length - 1) {
                hasNext = false;
            }
            else {
                i = i + 1;
                hasNext = true;
            }
            return hasNext;
        };

        _current = () => {
            return _array.get(i);
        };

        return {
            next = _next,
            current = _current
        };
    };

    _add = (value) => {
        if (_length > _array.length - 1) {
            _increase_size(10);
        }

        _array.set(_length, value);
        _length = _length + 1;
    };

    _set = (index, value) => {
        isIndexOutOfBounds = false;

        if (index > _length) {
            isIndexOutOfBounds = true;
        }
        else {
            _array.set(index, value);
        }

        return isIndexOutOfBounds;
    };

    _get = (index) => {
        return _array.get(index);
    };

    _removeAt = (index) => {
        if (index == _length - 1) {
            _array.set(_length - 1, null);
            _length = _length - 1;
        }
        else {
            i = index + 1;
            while (i < _length) {
                _array.set(i - 1, _array.get(i));
                i = i + 1;
            }
            _length = _length - 1;
        }
    };

    _enumerator = () => {
        return _Enumerator();  
    };

    return {
        length = () => {
            return _length;
        },
        add = _add,
        set = _set,
        get = _get,
        removeAt = _removeAt,
        enumerator = _enumerator
    };
};

// Complex string implementation - turns simple string into complex string
//
String = (s) => {
    __array_length = native (ref) => <@"std.Array.__array_length">;
    __array_get = native (ref, index) => <@"std.Array.__array_get">;
    __string_array = native (s) => <@"std.String.__string_array">;

    // Complex string
    _string_array = __string_array(s);

    _length = __array_length(_string_array);

    _Enumerator = () => {
        // TODO: Unary operator '-' is not supported at the moment
        // The workaround is representing a negative number with (0 - x)
        i = 0 - 1;

        return {
            next = () => {
                hasNext = null;
                if (i >= _length - 1) {
                    hasNext = false;
                }
                else {
                    i = i + 1;
                    hasNext = true;
                }
                return hasNext;
            },
            current = () => {
                return _get(i);
            }
        };
    };

    _get = (index) => {
        return __array_get(_string_array, index);
    };

    _toString = () => {
        sb = "";
        enumerator = _Enumerator();
        while (enumerator.next()) {
            sb = sb + enumerator.current();
        }
        return sb;
    };

    _toArray = () => {
        charArray = Array(_length);
        i = 0;
        while (i < charArray.length) {
            charArray.set(i, _get(i));
            i = i + 1;
        }
        return charArray;
    };

    _enumerator = () => {
        return _Enumerator();
    };

    _split = (delimiter) => {
        segmentCount = 0;
        i = 0;
        while (i < _length) {
            if (_get(i) == delimiter) {
                segmentCount = segmentCount + 1;
            }
            i = i + 1;
        }

        stringSegments = null;

        if (segmentCount == 0) {
            stringSegments = Array(1);
            stringSegments.set(0, _toString());
        }
        else {
            stringSegments = Array(segmentCount + 1);
            insertIndex = 0;
            sb = "";
            enumerator = _Enumerator();
            while (enumerator.next()) {
                char = enumerator.current();
                if (char != delimiter) {
                    sb = sb + char;
                }
                else {
                    stringSegments.set(insertIndex, sb);
                    sb = "";
                    insertIndex = insertIndex + 1;
                }
            }
            stringSegments.set(insertIndex, sb);
        }

        return stringSegments;
    };

    _replaceAll = (oldString, newString) => {

        xOldString = String(oldString);
        xNewString = String(newString);

        occurrenceIndices = ArrayList(10); // TODO: Use queue instead

        i = 0;
        while (i < _length) {
            j = 0;
            continiousCharOccurrences = 0;
            while (j < xOldString.length) {
                if (i + j < _length) {
                    if (xOldString.get(j) == _get(i + j)) {
                        continiousCharOccurrences = continiousCharOccurrences + 1;
                    }
                }
                j = j + 1;
            }

            if (continiousCharOccurrences == xOldString.length) {
                occurrenceIndices.add(i);
            }

            i = i + 1;
        }

        stringLength = _length;

        sb = "";
        cursor = 0;
        while (occurrenceIndices.length() > 0) {
            idx = occurrenceIndices.get(0);
            occurrenceIndices.removeAt(0);

            while (cursor < idx) {
                sb = sb + _get(cursor);
                cursor = cursor + 1;
            }

            newStringEnumerator = xNewString.enumerator();
            while (newStringEnumerator.next()) {
                sb = sb + newStringEnumerator.current();
            }

            cursor = cursor + xOldString.length;
        }

        // Add remaining characters
        while (cursor < _length) {
            sb = sb + _get(cursor);
            cursor = cursor + 1;
        }

        return String(sb);
    };

    _substring = (start, end) => {
        sb = "";
        i = start;
        while (i < end) {
            sb = sb + _get(i);
            i = i + 1;
        }
        return String(sb);
    };

    return {
        get = _get,
        length = _length,
        split = _split,
        replaceAll = _replaceAll,
        substring = _substring,
        enumerator = _enumerator,
        toString = _toString,
        toArray = _toArray
    };
};