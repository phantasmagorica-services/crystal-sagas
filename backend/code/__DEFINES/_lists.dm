#define LAZYLIST_ADD(L, I) if(isnull(L)) { L = list(); }; L += I;
#define LAZYLIST_REMOVE(L, I) if(!isnull(L)) { L -= I; if(length(L) == 0) {L = null}; };
#define LAZYLIST_FIND(L, I) L?.Find(I)
#define LAZYLIST_INIT(L) if(isnull(L)) { L = list(); };
#define LAZYLIST_DISTINCTADD(L, E) if(!L) { L = list(); }; L |= E;
#define LAZYLIST_ACCESS(L, K) L?[K]
#define LAZYLIST_LENGTH(L) length(L)
#define LAZYLIST_SET(L, K, V) if(!L) { L = list(); }; L[K] = V;
