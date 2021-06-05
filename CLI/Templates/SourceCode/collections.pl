﻿
// Linked list implementation
//
LinkedList = () => {

	// Fields
	__length = 0;
	__root = null;
	__head = null;

	// Private types
	_Node = (value) => {
		return {
			value = value,
			next = null
		};
	};

	_Enumerator = (startNode) => {
		current = startNode;
		skip = true;
		return {
			next = () => {
				b = null;
				// Has reached end?
				if (current == null) {
					b = false;
				}
				// First call should not update value of current
				else if (skip) {
					skip = false;
					b = true;
				}
				else {
					current = current.next;
					b = current != null;
				}
				return b;
			},

			current = () => {
				return current.value;
			}
		};
	};

	// Methods
	_add = (e) => {
		if (__length == 0) {
			n = _Node(e);
			__root = n;
			__head = n;
		}
		else {
			n = _Node(e);
			__head.next = n;
			__head = n;
		}
		__length = __length + 1;
	};

	_insertAt = (index, e) => {
		if (index == 0) {
			node = _Node(e);
			node.next = __root;
			__root = node;
		}
		else if (index == __length) {
			n = _Node(e);
			__head.next = n;
			__head = n;
		}
		else {
			i = 1;
			previous = __root;
			current = previous.next;
			while (i < index) {
				previous = current;
				current = current.next;
				i = i + 1;
			}
			
			node = _Node(e);
			node.next = current;
			previous.next = node;
		}
		__length = __length + 1;
	};

	// TODO: Implement O(1) operation
	_removeAt = (index) => {
		e = null;
		if (index == 0) {
			e = __root.value;
			__root = __root.next;
		}
		else {
			i = 1;
			previous = __root;
			current = previous.next;
			while (i < index) {
				previous = current;
				current = current.next;
				i = i + 1;
			}

			e = current.value;
			
			// If current node is last
			if (i == __length) {
				previous.next = null;
			}
			else {
				n = current.next;
				previous.next = n;
			}
		}

		__length = __length - 1;

		return e;
	};

	_remove = (e) => {
		previous = null;
		current = __root;

		// First value is e
		if (current.value == e) {
			if (current.next == null) {
				__root = null;
			}
			else {
				n = current.next;
				__root = n;
			}
		}
		else {
			previous = current;
			current = current.next;
			found = false;
			while (current != null && found == false) {
				if (current.value == e) {
					found = true;
				}
				else {
					previous = current;
					current = current.next;
				}
			}

			if (current.next == null) {
				previous.next = null;
			}
			else {
				n = current.next;
				previous.next = n;
			}
		}

		__length = __length - 1;
	};

	_get = (index) => {
		e = null;

		if (index == 0) {
			e = __root.value;
		}
		else if (index == __length) {
			e = __head;
		}
		else {
			i = 0;
			n = __root;
			while (i < index) {
				n = n.next;
				i = i + 1;
			}
			e = n.value;
		}

		return e;
	};

	_contains = (e) => {
		found = false;

		if (__length > 0) {
			if (__root.value == e) {
				found = true;
			}
			else {
				i = 0;
				n = __root;
				while (i < __length && found == false) {
					if (n.value == e) {
						found = true;
					}
					else {
						n = n.next;
						i = i + 1;
					}
				}
			}
		}

		return found;
	};

	_length = () => {
		return __length;
	};

	_enumerator = () => {
		return _Enumerator(__root);
	};

	_toList = () => {
		return __ls;
	};

	_toString = () => {
		sb = LinkedList();
		sb.add("[");
		if (__length > 0) {
			e = _Enumerator(__root);
			i = 0;
			while (e.next()) {
				sb.add(e.current());
				if (i != __length - 1) {
					sb.add(",");
				}
				i = i + 1;
			}
		}
		sb.add("]");
		s = "";
		se = sb.enumerator();
		while (se.next()) {
			s = s + se.current();
		}
		return s;
	};

	__ls = {
		add = _add,
		insertAt = _insertAt,
		removeAt = _removeAt,
		remove = _remove,
		get = _get,
		contains = _contains,
		length = _length,
		enumerator = _enumerator,
		toList = _toList,
		toString = _toString
	};

	return __ls;
};


// Stack implementation
//
// dependencies:
//	LinkedList
//
Stack = () => {
	
	// Fields
	__list = LinkedList();

	// Methods
	_push = (e) => {
		__list.insertAt(0, e);
	};

	_pop = () => {
		return __list.removeAt(0);
	};

	_peek = () => {
		return __list.get(0);
	};

	_length = () => {
		return __list.length();
	};

	_enumerator = () => {
		return __list.enumerator();
	};

	_toList = () => {
		return __list;
	};

	_toString = () => {
		return __list.toString();
	};

	return { 
		push = _push,
		pop = _pop,
		peek = _peek,
		length = _length,
		enumerator = _enumerator,
		toList = _toList,
		toString = _toString
	};
};


// Queue implementation
//
// dependencies:
//	LinkedList
//
Queue = () => {

	// Fields
	__list = LinkedList();

	// Methods
	_enqueue = (e) => {
		__list.add(e);
	};

	_dequeue = () => {
		return __list.removeAt(0);
	};

	_peek = () => {
		return __list.get(0);
	};

	_length = () => {
		return __list.length();
	};

	_enumerator = () => {
		return __list.enumerator();
	};

	_toList = () => {
		return __list;
	};

	_toString = () => {
		return __list.toString();
	};

	return {
		enqueue = _enqueue,
		dequeue = _dequeue,
		peek = _peek,
		length = _length,
		enumerator = _enumerator,
		toList = _toList,
		toString = _toString
	};
};

foreachin = (list, consumer) => {
	enumerator = list.enumerator();
	i = 0;
	while (enumerator.next()) {
		consumer(enumerator.current(), i);
		i = i + 1;
	}
};