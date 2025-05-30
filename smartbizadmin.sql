PGDMP                      }            smartbizadmin    17.4    17.4 j    W           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            X           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            Y           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            Z           1262    16695    smartbizadmin    DATABASE     s   CREATE DATABASE smartbizadmin WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en-US';
    DROP DATABASE smartbizadmin;
                     postgres    false            f           1247    16697    category_type    TYPE     L   CREATE TYPE public.category_type AS ENUM (
    'Coffee Shop',
    'Kost'
);
     DROP TYPE public.category_type;
       public               postgres    false            �            1255    16869    trigger_set_timestamp()    FUNCTION     �   CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.trigger_set_timestamp();
       public               postgres    false            �            1259    16701    bookings    TABLE       CREATE TABLE public.bookings (
    id integer NOT NULL,
    user_id integer NOT NULL,
    room_id integer NOT NULL,
    checkin_date date NOT NULL,
    checkout_date date NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT bookings_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('confirmed'::character varying)::text, ('cancelled'::character varying)::text])))
);
    DROP TABLE public.bookings;
       public         heap r       postgres    false            �            1259    16707    bookings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.bookings_id_seq;
       public               postgres    false    217            [           0    0    bookings_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;
          public               postgres    false    218            �            1259    16708    cart    TABLE       CREATE TABLE public.cart (
    id integer NOT NULL,
    user_id integer NOT NULL,
    menu_item_id integer NOT NULL,
    quantity integer NOT NULL,
    total_price numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.cart;
       public         heap r       postgres    false            �            1259    16712    cart_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.cart_id_seq;
       public               postgres    false    219            \           0    0    cart_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;
          public               postgres    false    220            �            1259    16713 	   inventory    TABLE     W  CREATE TABLE public.inventory (
    id integer NOT NULL,
    item_name character varying(100) NOT NULL,
    stock integer NOT NULL,
    minimum_stock integer NOT NULL,
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    category character varying(100),
    image_url character varying(255),
    expiration_date date
);
    DROP TABLE public.inventory;
       public         heap r       postgres    false            �            1259    16717    inventory_id_seq    SEQUENCE     �   CREATE SEQUENCE public.inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.inventory_id_seq;
       public               postgres    false    221            ]           0    0    inventory_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.inventory_id_seq OWNED BY public.inventory.id;
          public               postgres    false    222            �            1259    16718    inventory_transactions    TABLE     �  CREATE TABLE public.inventory_transactions (
    id integer NOT NULL,
    inventory_id integer NOT NULL,
    type character varying(10) NOT NULL,
    quantity integer NOT NULL,
    description text,
    date date NOT NULL,
    created_by integer NOT NULL,
    CONSTRAINT inventory_transactions_type_check CHECK (((type)::text = ANY (ARRAY[('add'::character varying)::text, ('remove'::character varying)::text])))
);
 *   DROP TABLE public.inventory_transactions;
       public         heap r       postgres    false            �            1259    16724    inventory_transactions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.inventory_transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.inventory_transactions_id_seq;
       public               postgres    false    223            ^           0    0    inventory_transactions_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.inventory_transactions_id_seq OWNED BY public.inventory_transactions.id;
          public               postgres    false    224            �            1259    16725 
   menu_items    TABLE     �  CREATE TABLE public.menu_items (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    price numeric(10,2) NOT NULL,
    category character varying(50),
    description text,
    availability character varying(50) DEFAULT 'available'::character varying,
    CONSTRAINT menu_items_availability_check CHECK (((availability)::text = ANY (ARRAY[('available'::character varying)::text, ('unavailable'::character varying)::text])))
);
    DROP TABLE public.menu_items;
       public         heap r       postgres    false            �            1259    16732    menu_items_id_seq    SEQUENCE     �   CREATE SEQUENCE public.menu_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.menu_items_id_seq;
       public               postgres    false    225            _           0    0    menu_items_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.menu_items_id_seq OWNED BY public.menu_items.id;
          public               postgres    false    226            �            1259    16733    order_items    TABLE       CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    menu_item_id integer NOT NULL,
    quantity integer NOT NULL,
    total_price numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.order_items;
       public         heap r       postgres    false            �            1259    16737    order_items_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.order_items_id_seq;
       public               postgres    false    227            `           0    0    order_items_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;
          public               postgres    false    228            �            1259    16738    orders    TABLE     �  CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id integer NOT NULL,
    total_price numeric(10,2) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('completed'::character varying)::text, ('cancelled'::character varying)::text])))
);
    DROP TABLE public.orders;
       public         heap r       postgres    false            �            1259    16744    orders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public               postgres    false    229            a           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public               postgres    false    230            �            1259    16873    pembayaran_kos    TABLE     �  CREATE TABLE public.pembayaran_kos (
    id integer NOT NULL,
    penghuni_id integer NOT NULL,
    bulan_tagihan character varying(7) NOT NULL,
    status_pembayaran character varying(20) DEFAULT 'Belum Bayar'::character varying NOT NULL,
    tanggal_pembayaran_lunas date,
    catatan_pembayaran text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    jumlah_bayar numeric(12,2) DEFAULT 0.00 NOT NULL,
    bukti_transfer_path character varying(255),
    metode_pembayaran character varying(50),
    CONSTRAINT pembayaran_kos_status_pembayaran_check CHECK (((status_pembayaran)::text = ANY ((ARRAY['Belum Bayar'::character varying, 'Lunas'::character varying])::text[])))
);
 "   DROP TABLE public.pembayaran_kos;
       public         heap r       postgres    false            �            1259    16872    pembayaran_kos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pembayaran_kos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.pembayaran_kos_id_seq;
       public               postgres    false    240            b           0    0    pembayaran_kos_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.pembayaran_kos_id_seq OWNED BY public.pembayaran_kos.id;
          public               postgres    false    239            �            1259    16852    penghuni    TABLE     �  CREATE TABLE public.penghuni (
    id integer NOT NULL,
    room_id integer NOT NULL,
    nama_penghuni character varying(255) NOT NULL,
    nomor_hp_penghuni character varying(20),
    nama_orang_tua character varying(255),
    pekerjaan_penghuni character varying(100),
    nomor_hp_orang_tua_wali character varying(20),
    tanggal_masuk date,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.penghuni;
       public         heap r       postgres    false            �            1259    16851    penghuni_id_seq    SEQUENCE     �   CREATE SEQUENCE public.penghuni_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.penghuni_id_seq;
       public               postgres    false    238            c           0    0    penghuni_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.penghuni_id_seq OWNED BY public.penghuni.id;
          public               postgres    false    237            �            1259    16745    rooms    TABLE     �  CREATE TABLE public.rooms (
    id integer NOT NULL,
    room_name character varying(100) NOT NULL,
    price numeric(10,2) NOT NULL,
    facilities text,
    availability boolean DEFAULT true,
    tenant_name character varying(255),
    tenant_phone character varying(25),
    parent_name character varying(255),
    parent_phone character varying(25),
    occupation character varying(100),
    payment_status_current_month character varying(20) DEFAULT 'Belum Bayar'::character varying
);
    DROP TABLE public.rooms;
       public         heap r       postgres    false            �            1259    16751    rooms_id_seq    SEQUENCE     �   CREATE SEQUENCE public.rooms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.rooms_id_seq;
       public               postgres    false    231            d           0    0    rooms_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;
          public               postgres    false    232            �            1259    16752    transactions    TABLE     5  CREATE TABLE public.transactions (
    id integer NOT NULL,
    type character varying(10) NOT NULL,
    amount numeric(10,2) NOT NULL,
    description text,
    category character varying(255),
    payment_method character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by integer NOT NULL,
    CONSTRAINT transactions_type_check CHECK (((type)::text = ANY (ARRAY[('income'::character varying)::text, ('expense'::character varying)::text])))
);
     DROP TABLE public.transactions;
       public         heap r       postgres    false            �            1259    16760    transactions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.transactions_id_seq;
       public               postgres    false    233            e           0    0    transactions_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;
          public               postgres    false    234            �            1259    16761    users    TABLE     �  CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY (ARRAY[('admin'::character varying)::text, ('superadmin'::character varying)::text])))
);
    DROP TABLE public.users;
       public         heap r       postgres    false            �            1259    16766    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public               postgres    false    235            f           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public               postgres    false    236            \           2604    16767    bookings id    DEFAULT     j   ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);
 :   ALTER TABLE public.bookings ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    218    217            _           2604    16768    cart id    DEFAULT     b   ALTER TABLE ONLY public.cart ALTER COLUMN id SET DEFAULT nextval('public.cart_id_seq'::regclass);
 6   ALTER TABLE public.cart ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219            a           2604    16769    inventory id    DEFAULT     l   ALTER TABLE ONLY public.inventory ALTER COLUMN id SET DEFAULT nextval('public.inventory_id_seq'::regclass);
 ;   ALTER TABLE public.inventory ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221            c           2604    16770    inventory_transactions id    DEFAULT     �   ALTER TABLE ONLY public.inventory_transactions ALTER COLUMN id SET DEFAULT nextval('public.inventory_transactions_id_seq'::regclass);
 H   ALTER TABLE public.inventory_transactions ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    223            d           2604    16771    menu_items id    DEFAULT     n   ALTER TABLE ONLY public.menu_items ALTER COLUMN id SET DEFAULT nextval('public.menu_items_id_seq'::regclass);
 <   ALTER TABLE public.menu_items ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    226    225            f           2604    16772    order_items id    DEFAULT     p   ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);
 =   ALTER TABLE public.order_items ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    228    227            h           2604    16773 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    230    229            v           2604    16876    pembayaran_kos id    DEFAULT     v   ALTER TABLE ONLY public.pembayaran_kos ALTER COLUMN id SET DEFAULT nextval('public.pembayaran_kos_id_seq'::regclass);
 @   ALTER TABLE public.pembayaran_kos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    239    240    240            s           2604    16855    penghuni id    DEFAULT     j   ALTER TABLE ONLY public.penghuni ALTER COLUMN id SET DEFAULT nextval('public.penghuni_id_seq'::regclass);
 :   ALTER TABLE public.penghuni ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    238    237    238            k           2604    16774    rooms id    DEFAULT     d   ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);
 7   ALTER TABLE public.rooms ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    232    231            n           2604    16775    transactions id    DEFAULT     r   ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);
 >   ALTER TABLE public.transactions ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    234    233            q           2604    16776    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    236    235            =          0    16701    bookings 
   TABLE DATA           i   COPY public.bookings (id, user_id, room_id, checkin_date, checkout_date, status, created_at) FROM stdin;
    public               postgres    false    217   5�       ?          0    16708    cart 
   TABLE DATA           \   COPY public.cart (id, user_id, menu_item_id, quantity, total_price, created_at) FROM stdin;
    public               postgres    false    219   R�       A          0    16713 	   inventory 
   TABLE DATA           |   COPY public.inventory (id, item_name, stock, minimum_stock, last_updated, category, image_url, expiration_date) FROM stdin;
    public               postgres    false    221   o�       C          0    16718    inventory_transactions 
   TABLE DATA           q   COPY public.inventory_transactions (id, inventory_id, type, quantity, description, date, created_by) FROM stdin;
    public               postgres    false    223   ��       E          0    16725 
   menu_items 
   TABLE DATA           Z   COPY public.menu_items (id, name, price, category, description, availability) FROM stdin;
    public               postgres    false    225   ��       G          0    16733    order_items 
   TABLE DATA           d   COPY public.order_items (id, order_id, menu_item_id, quantity, total_price, created_at) FROM stdin;
    public               postgres    false    227   ��       I          0    16738    orders 
   TABLE DATA           N   COPY public.orders (id, user_id, total_price, status, created_at) FROM stdin;
    public               postgres    false    229   Ս       T          0    16873    pembayaran_kos 
   TABLE DATA           �   COPY public.pembayaran_kos (id, penghuni_id, bulan_tagihan, status_pembayaran, tanggal_pembayaran_lunas, catatan_pembayaran, created_at, updated_at, jumlah_bayar, bukti_transfer_path, metode_pembayaran) FROM stdin;
    public               postgres    false    240   �       R          0    16852    penghuni 
   TABLE DATA           �   COPY public.penghuni (id, room_id, nama_penghuni, nomor_hp_penghuni, nama_orang_tua, pekerjaan_penghuni, nomor_hp_orang_tua_wali, tanggal_masuk, created_at, updated_at) FROM stdin;
    public               postgres    false    238   �       K          0    16745    rooms 
   TABLE DATA           �   COPY public.rooms (id, room_name, price, facilities, availability, tenant_name, tenant_phone, parent_name, parent_phone, occupation, payment_status_current_month) FROM stdin;
    public               postgres    false    231   ��       M          0    16752    transactions 
   TABLE DATA           �   COPY public.transactions (id, type, amount, description, category, payment_method, created_at, updated_at, created_by) FROM stdin;
    public               postgres    false    233   ��       O          0    16761    users 
   TABLE DATA           I   COPY public.users (id, username, password, role, created_at) FROM stdin;
    public               postgres    false    235   �       g           0    0    bookings_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.bookings_id_seq', 1, false);
          public               postgres    false    218            h           0    0    cart_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.cart_id_seq', 1, false);
          public               postgres    false    220            i           0    0    inventory_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.inventory_id_seq', 32, true);
          public               postgres    false    222            j           0    0    inventory_transactions_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.inventory_transactions_id_seq', 1, false);
          public               postgres    false    224            k           0    0    menu_items_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.menu_items_id_seq', 20, true);
          public               postgres    false    226            l           0    0    order_items_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.order_items_id_seq', 1, false);
          public               postgres    false    228            m           0    0    orders_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.orders_id_seq', 1, false);
          public               postgres    false    230            n           0    0    pembayaran_kos_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.pembayaran_kos_id_seq', 16, true);
          public               postgres    false    239            o           0    0    penghuni_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.penghuni_id_seq', 4, true);
          public               postgres    false    237            p           0    0    rooms_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.rooms_id_seq', 11, true);
          public               postgres    false    232            q           0    0    transactions_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.transactions_id_seq', 50, true);
          public               postgres    false    234            r           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 9, true);
          public               postgres    false    236            �           2606    16778    bookings bookings_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.bookings DROP CONSTRAINT bookings_pkey;
       public                 postgres    false    217            �           2606    16780    cart cart_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_pkey;
       public                 postgres    false    219            �           2606    16782    inventory inventory_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.inventory DROP CONSTRAINT inventory_pkey;
       public                 postgres    false    221            �           2606    16784 2   inventory_transactions inventory_transactions_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.inventory_transactions
    ADD CONSTRAINT inventory_transactions_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.inventory_transactions DROP CONSTRAINT inventory_transactions_pkey;
       public                 postgres    false    223            �           2606    16786    menu_items menu_items_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.menu_items DROP CONSTRAINT menu_items_pkey;
       public                 postgres    false    225            �           2606    16788    order_items order_items_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_pkey;
       public                 postgres    false    227            �           2606    16790    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public                 postgres    false    229            �           2606    16884 "   pembayaran_kos pembayaran_kos_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.pembayaran_kos
    ADD CONSTRAINT pembayaran_kos_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.pembayaran_kos DROP CONSTRAINT pembayaran_kos_pkey;
       public                 postgres    false    240            �           2606    16861    penghuni penghuni_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.penghuni
    ADD CONSTRAINT penghuni_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.penghuni DROP CONSTRAINT penghuni_pkey;
       public                 postgres    false    238            �           2606    16792    rooms rooms_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.rooms DROP CONSTRAINT rooms_pkey;
       public                 postgres    false    231            �           2606    16794    transactions transactions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
       public                 postgres    false    233            �           2606    16886 +   pembayaran_kos uq_pembayaran_penghuni_bulan 
   CONSTRAINT     |   ALTER TABLE ONLY public.pembayaran_kos
    ADD CONSTRAINT uq_pembayaran_penghuni_bulan UNIQUE (penghuni_id, bulan_tagihan);
 U   ALTER TABLE ONLY public.pembayaran_kos DROP CONSTRAINT uq_pembayaran_penghuni_bulan;
       public                 postgres    false    240    240            �           2606    16863    penghuni uq_room_id_aktif 
   CONSTRAINT     W   ALTER TABLE ONLY public.penghuni
    ADD CONSTRAINT uq_room_id_aktif UNIQUE (room_id);
 C   ALTER TABLE ONLY public.penghuni DROP CONSTRAINT uq_room_id_aktif;
       public                 postgres    false    238            �           2606    16796    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 postgres    false    235            �           2620    16892 +   pembayaran_kos set_timestamp_pembayaran_kos    TRIGGER     �   CREATE TRIGGER set_timestamp_pembayaran_kos BEFORE UPDATE ON public.pembayaran_kos FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();
 D   DROP TRIGGER set_timestamp_pembayaran_kos ON public.pembayaran_kos;
       public               postgres    false    240    241            �           2620    16870    penghuni set_timestamp_penghuni    TRIGGER     �   CREATE TRIGGER set_timestamp_penghuni BEFORE UPDATE ON public.penghuni FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();
 8   DROP TRIGGER set_timestamp_penghuni ON public.penghuni;
       public               postgres    false    238    241            �           2606    16797    bookings bookings_room_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(id);
 H   ALTER TABLE ONLY public.bookings DROP CONSTRAINT bookings_room_id_fkey;
       public               postgres    false    231    217    4753            �           2606    16802    bookings bookings_user_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 H   ALTER TABLE ONLY public.bookings DROP CONSTRAINT bookings_user_id_fkey;
       public               postgres    false    217    235    4757            �           2606    16807    cart cart_menu_item_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_menu_item_id_fkey FOREIGN KEY (menu_item_id) REFERENCES public.menu_items(id);
 E   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_menu_item_id_fkey;
       public               postgres    false    4747    225    219            �           2606    16812    cart cart_user_id_fkey    FK CONSTRAINT     u   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 @   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_user_id_fkey;
       public               postgres    false    235    219    4757            �           2606    16896 (   pembayaran_kos fk_pembayaran_kos_room_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.pembayaran_kos
    ADD CONSTRAINT fk_pembayaran_kos_room_id FOREIGN KEY (penghuni_id) REFERENCES public.rooms(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.pembayaran_kos DROP CONSTRAINT fk_pembayaran_kos_room_id;
       public               postgres    false    231    4753    240            �           2606    16817 =   inventory_transactions inventory_transactions_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.inventory_transactions
    ADD CONSTRAINT inventory_transactions_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 g   ALTER TABLE ONLY public.inventory_transactions DROP CONSTRAINT inventory_transactions_created_by_fkey;
       public               postgres    false    223    4757    235            �           2606    16822 ?   inventory_transactions inventory_transactions_inventory_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.inventory_transactions
    ADD CONSTRAINT inventory_transactions_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES public.inventory(id);
 i   ALTER TABLE ONLY public.inventory_transactions DROP CONSTRAINT inventory_transactions_inventory_id_fkey;
       public               postgres    false    223    4743    221            �           2606    16827 )   order_items order_items_menu_item_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_menu_item_id_fkey FOREIGN KEY (menu_item_id) REFERENCES public.menu_items(id);
 S   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_menu_item_id_fkey;
       public               postgres    false    225    4747    227            �           2606    16832 %   order_items order_items_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);
 O   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_order_id_fkey;
       public               postgres    false    227    4751    229            �           2606    16837    orders orders_user_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_user_id_fkey;
       public               postgres    false    229    4757    235            �           2606    16864    penghuni penghuni_room_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.penghuni
    ADD CONSTRAINT penghuni_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.penghuni DROP CONSTRAINT penghuni_room_id_fkey;
       public               postgres    false    238    4753    231            �           2606    16842 )   transactions transactions_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 S   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_created_by_fkey;
       public               postgres    false    235    4757    233            =      x������ � �      ?      x������ � �      A     x��ѱN1 ��������'q6$6$�.�K˵pw����@�:(���l܏S�BjIVmMj�%�����,�~�JCO�	�}�bJ(֫��y�lJi�q���:�n���2��[ޖ�QX$����eb0�p��S�r ��/��j�����D�K,F�]>w�dA��$�X�.��q>��8T&���P�ꀫ�4�dYJ�ƈ(�=��Me���C��C~��y�'�%9MLQU���E�P#U���5�| �ØQ      C      x������ � �      E     x����N�0�ϛ��P9�B8�@*A����6�&��Z�B<=.4��
��g���:�)^�@���r%%x�� �<*~��HAqo���[�G��w�����Z<:J!�K[��~O���!t�	����K�אC��������7шN��h'"���K�Ǖn�>*��{�C���M�l*�J��N!�+g�E�3�����9�9R�~���`9�jhfrz@N�T����.)���S�h��`ri��Qs^�VEQ|����      G      x������ � �      I      x������ � �      T     x���ێ�0�k�)z�jfl����\"�\��e�6[U�=N���
�l��W�/��Fh�@�H|<nc���#�qs���	���tL ����0\@�?wqٿ_�7���qŧ��ؽ���v��}�{�];Gk�#h`�F��w�5oH���/w�K��Kf�*�"�N6�I���#�32��z�I����.Ԩ*�<D3�l��َ�Q1�é=�,��d��Z��tz��u��p��fj;�c�1cQ �K��,��)�T�wޒ��~D����e\uWj������.R4~��_���QQj������B %�7���2��!hHq�H9G���~`���Typ��T�]���Z,�JP�4�y���:�
��`��^)[��J:��6}Y��u�m'�c�z_�i+>m�s����3��S�L�(�b&����V;��D��k/+mߞ{��Ӻ��&������ܩ��)�4�+���U�8 J���\���-�W%���A?�|Ӻx�Y:r������H5�O�M����P��M6M���oR      R   �   x�}ͱ�0�����ȵ����b�	�`�#�H�o�������k��n��=�Q�E��2��"�'�o�W�+�F�хh]Yg��@���
*h�[�c�+�6l��Y�=򟂇3K�-���d:�`�&��V��r��NUW*��*{6�      K   2  x��ұn�0��x
? �l�7u�ڤʖ%˩��4x0XU��=�j:��P���g��|�@r�fRB����ȋ���t�.��%���Ԓ���e�uؾ^,��XЉ|����$�������F~��^AR���?�*�����ݞ?��D�ZrV����Q��4<�����i԰��������D�}Lݸ�ȾӑѼȕ6sD�Q����h���b���2�����'g�h�:t�n���9p1��dpMn_{��S�E�q\伣�����o��'KMs�x�x��|�-�p����v;K����"a      M   �  x��WMo�F=s� &�c��&�@�	�E/�ldڦ#�.E��}�RD�����.�y�fvސC��|ʊE���IK����7,��s���iX<$�	u���(��W6U�0��"ɋi9�l�Ϳ��P��b�9�CE���b��*_��UynS��BD�6�m3��0[%|����O? �y6������[��)�|(�^?�O�Ͳy'���{nRÙ<
ǩ|��B��$���zy�RD�|�S
��1-l"B���Z\f���fe�ɳ_ ������
x�D�nO��E�IGC�#�ޡ��F�up�Hu�B�~%��wwY�&�2��y��2��0^R�U�2Tu��k����횆��y�RƝ4�k��:_?3H?L�*���BD��ev�s/;���a��(�_��@D���h����KX��%����dYW��T9^�֙(D$�R}+�n(S�Б܁���Nn�{Y�
������=����O�@�����a��C��{�=�S���.
)O�EG͑�N��Ӱ�U{��sB��l-A��!T��=a<Ϫ|�rG�/�O:�5jVC��K53��"��:1�+L\dU���į����$�F!"M����׋�:
(/ej�.�����]S�U��+,W��Xg���BD�(�]�:;ԯ`m3ő�%D!�m߆��O`���"[�!
��D��2�W�)��82 ��˹�B����k�I(���~�`7�P6���0x����O\M96�j������	�4m�:cqڤ��|wf���a6X3��4�c��:
hWM���j|u����az� 7M;1�����|w�< خ�� ���~��cx�fŲ���t�S����!l*�`�;�Ȝ]p\N�zY-q�+�yE��Yf;q "��W7�g����JVЉ(DT�yB�t[�)���V8���J`�iX�:
��SB��y��      O   �  x�u�K��@�5��^����FA[QP�̦@Ă�T�}�~��;�N����9ɗ{����Z�={��m���̛5�*�8	30���Iȗ��q��g����~ߡ���^Ne˷�41��O����º���[+������J��0j��9Js�`4v�T�Ύ�8d2�ݎ��'[���+�K�y�إ�k:����δE�}�	K&�)��˸�D|.�� v�bs6��q$_�p�);�IG���;������@Mkc..?�<�ؠu����B7�]�iN��ug�iTb��fۅ_>�+4]��h3ƨ�h�����]�|@%*ÑwmC��4 �؜� ��P�;��6�=�/��
������>�D�t]�8���     