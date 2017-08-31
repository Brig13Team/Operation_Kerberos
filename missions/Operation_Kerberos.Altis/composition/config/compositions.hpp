#define COMPOSITION(NAME) class NAME { \
    class header { \
        #include 'compositions\NAME\header.sqe' \
    }; \
    class composition { \
        #include 'compositions\NAME\composition.sqe' \
    }; \
}

class TestComp {
    class header {
        #include "compositions\TestComp\header.sqe"
    };
    class composition {
        #include "compositions\TestComp\composition.sqe"
    };
};
