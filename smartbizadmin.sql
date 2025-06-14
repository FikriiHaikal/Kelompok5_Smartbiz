PGDMP      3                }            smartbizadmin    17.3    17.3 F    V           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            W           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            X           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            Y           1262    18462    smartbizadmin    DATABASE     s   CREATE DATABASE smartbizadmin WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en-US';
    DROP DATABASE smartbizadmin;
                     postgres    false            ^           1247    18464    category_type    TYPE     L   CREATE TYPE public.category_type AS ENUM (
    'Coffee Shop',
    'Kost'
);
     DROP TYPE public.category_type;
       public               postgres    false            �            1255    18469    trigger_set_timestamp()    FUNCTION     �   CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.trigger_set_timestamp();
       public               postgres    false            �            1259    18470 	   inventory    TABLE     W  CREATE TABLE public.inventory (
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
       public         heap r       postgres    false            �            1259    18474    inventory_id_seq    SEQUENCE     �   CREATE SEQUENCE public.inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.inventory_id_seq;
       public               postgres    false    217            Z           0    0    inventory_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.inventory_id_seq OWNED BY public.inventory.id;
          public               postgres    false    218            �            1259    18475 
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
       public         heap r       postgres    false            �            1259    18482    menu_items_id_seq    SEQUENCE     �   CREATE SEQUENCE public.menu_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.menu_items_id_seq;
       public               postgres    false    219            [           0    0    menu_items_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.menu_items_id_seq OWNED BY public.menu_items.id;
          public               postgres    false    220            �            1259    18483    order_items    TABLE       CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    menu_item_id integer NOT NULL,
    quantity integer NOT NULL,
    total_price numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.order_items;
       public         heap r       postgres    false            �            1259    18487    order_items_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.order_items_id_seq;
       public               postgres    false    221            \           0    0    order_items_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;
          public               postgres    false    222            �            1259    18488    orders    TABLE     �  CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id integer NOT NULL,
    total_price numeric(10,2) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('completed'::character varying)::text, ('cancelled'::character varying)::text])))
);
    DROP TABLE public.orders;
       public         heap r       postgres    false            �            1259    18494    orders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public               postgres    false    223            ]           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public               postgres    false    224            �            1259    18495    pembayaran_kos    TABLE       CREATE TABLE public.pembayaran_kos (
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
    CONSTRAINT pembayaran_kos_status_pembayaran_check CHECK (((status_pembayaran)::text = ANY (ARRAY[('Belum Bayar'::character varying)::text, ('Lunas'::character varying)::text])))
);
 "   DROP TABLE public.pembayaran_kos;
       public         heap r       postgres    false            �            1259    18505    pembayaran_kos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pembayaran_kos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.pembayaran_kos_id_seq;
       public               postgres    false    225            ^           0    0    pembayaran_kos_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.pembayaran_kos_id_seq OWNED BY public.pembayaran_kos.id;
          public               postgres    false    226            �            1259    18506    rooms    TABLE     �  CREATE TABLE public.rooms (
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
       public         heap r       postgres    false            �            1259    18513    rooms_id_seq    SEQUENCE     �   CREATE SEQUENCE public.rooms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.rooms_id_seq;
       public               postgres    false    227            _           0    0    rooms_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;
          public               postgres    false    228            �            1259    18514    transactions    TABLE     5  CREATE TABLE public.transactions (
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
       public         heap r       postgres    false            �            1259    18522    transactions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.transactions_id_seq;
       public               postgres    false    229            `           0    0    transactions_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;
          public               postgres    false    230            �            1259    18523    users    TABLE     �  CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY (ARRAY[('admin'::character varying)::text, ('superadmin'::character varying)::text])))
);
    DROP TABLE public.users;
       public         heap r       postgres    false            �            1259    18528    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public               postgres    false    231            a           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public               postgres    false    232            ~           2604    18529    inventory id    DEFAULT     l   ALTER TABLE ONLY public.inventory ALTER COLUMN id SET DEFAULT nextval('public.inventory_id_seq'::regclass);
 ;   ALTER TABLE public.inventory ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    218    217            �           2604    18530    menu_items id    DEFAULT     n   ALTER TABLE ONLY public.menu_items ALTER COLUMN id SET DEFAULT nextval('public.menu_items_id_seq'::regclass);
 <   ALTER TABLE public.menu_items ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219            �           2604    18531    order_items id    DEFAULT     p   ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);
 =   ALTER TABLE public.order_items ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221            �           2604    18532 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    223            �           2604    18533    pembayaran_kos id    DEFAULT     v   ALTER TABLE ONLY public.pembayaran_kos ALTER COLUMN id SET DEFAULT nextval('public.pembayaran_kos_id_seq'::regclass);
 @   ALTER TABLE public.pembayaran_kos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    226    225            �           2604    18534    rooms id    DEFAULT     d   ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);
 7   ALTER TABLE public.rooms ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    228    227            �           2604    18535    transactions id    DEFAULT     r   ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);
 >   ALTER TABLE public.transactions ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    230    229            �           2604    18536    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    232    231            D          0    18470 	   inventory 
   TABLE DATA           |   COPY public.inventory (id, item_name, stock, minimum_stock, last_updated, category, image_url, expiration_date) FROM stdin;
    public               postgres    false    217   vZ       F          0    18475 
   menu_items 
   TABLE DATA           Z   COPY public.menu_items (id, name, price, category, description, availability) FROM stdin;
    public               postgres    false    219   [       H          0    18483    order_items 
   TABLE DATA           d   COPY public.order_items (id, order_id, menu_item_id, quantity, total_price, created_at) FROM stdin;
    public               postgres    false    221   \       J          0    18488    orders 
   TABLE DATA           N   COPY public.orders (id, user_id, total_price, status, created_at) FROM stdin;
    public               postgres    false    223   %\       L          0    18495    pembayaran_kos 
   TABLE DATA           �   COPY public.pembayaran_kos (id, penghuni_id, bulan_tagihan, status_pembayaran, tanggal_pembayaran_lunas, catatan_pembayaran, created_at, updated_at, jumlah_bayar, bukti_transfer_path, metode_pembayaran) FROM stdin;
    public               postgres    false    225   B\       N          0    18506    rooms 
   TABLE DATA           �   COPY public.rooms (id, room_name, price, facilities, availability, tenant_name, tenant_phone, parent_name, parent_phone, occupation, payment_status_current_month) FROM stdin;
    public               postgres    false    227   �_       P          0    18514    transactions 
   TABLE DATA           �   COPY public.transactions (id, type, amount, description, category, payment_method, created_at, updated_at, created_by) FROM stdin;
    public               postgres    false    229   a       R          0    18523    users 
   TABLE DATA           I   COPY public.users (id, username, password, role, created_at) FROM stdin;
    public               postgres    false    231   �h       b           0    0    inventory_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.inventory_id_seq', 52, true);
          public               postgres    false    218            c           0    0    menu_items_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.menu_items_id_seq', 31, true);
          public               postgres    false    220            d           0    0    order_items_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.order_items_id_seq', 1, false);
          public               postgres    false    222            e           0    0    orders_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.orders_id_seq', 1, false);
          public               postgres    false    224            f           0    0    pembayaran_kos_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.pembayaran_kos_id_seq', 33, true);
          public               postgres    false    226            g           0    0    rooms_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.rooms_id_seq', 19, true);
          public               postgres    false    228            h           0    0    transactions_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.transactions_id_seq', 95, true);
          public               postgres    false    230            i           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 21, true);
          public               postgres    false    232            �           2606    18538    inventory inventory_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.inventory DROP CONSTRAINT inventory_pkey;
       public                 postgres    false    217            �           2606    18540    menu_items menu_items_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.menu_items DROP CONSTRAINT menu_items_pkey;
       public                 postgres    false    219            �           2606    18542    order_items order_items_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_pkey;
       public                 postgres    false    221            �           2606    18544    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public                 postgres    false    223            �           2606    18546 "   pembayaran_kos pembayaran_kos_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.pembayaran_kos
    ADD CONSTRAINT pembayaran_kos_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.pembayaran_kos DROP CONSTRAINT pembayaran_kos_pkey;
       public                 postgres    false    225            �           2606    18548    rooms rooms_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.rooms DROP CONSTRAINT rooms_pkey;
       public                 postgres    false    227            �           2606    18550    transactions transactions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
       public                 postgres    false    229            �           2606    18552    users unique_username 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_username UNIQUE (username);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT unique_username;
       public                 postgres    false    231            �           2606    18554 +   pembayaran_kos uq_pembayaran_penghuni_bulan 
   CONSTRAINT     |   ALTER TABLE ONLY public.pembayaran_kos
    ADD CONSTRAINT uq_pembayaran_penghuni_bulan UNIQUE (penghuni_id, bulan_tagihan);
 U   ALTER TABLE ONLY public.pembayaran_kos DROP CONSTRAINT uq_pembayaran_penghuni_bulan;
       public                 postgres    false    225    225            �           2606    18556    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 postgres    false    231            �           2620    18557 +   pembayaran_kos set_timestamp_pembayaran_kos    TRIGGER     �   CREATE TRIGGER set_timestamp_pembayaran_kos BEFORE UPDATE ON public.pembayaran_kos FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();
 D   DROP TRIGGER set_timestamp_pembayaran_kos ON public.pembayaran_kos;
       public               postgres    false    233    225            �           2606    18558 (   pembayaran_kos fk_pembayaran_kos_room_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.pembayaran_kos
    ADD CONSTRAINT fk_pembayaran_kos_room_id FOREIGN KEY (penghuni_id) REFERENCES public.rooms(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.pembayaran_kos DROP CONSTRAINT fk_pembayaran_kos_room_id;
       public               postgres    false    225    4774    227            �           2606    18563 )   order_items order_items_menu_item_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_menu_item_id_fkey FOREIGN KEY (menu_item_id) REFERENCES public.menu_items(id);
 S   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_menu_item_id_fkey;
       public               postgres    false    221    219    4764            �           2606    18568 %   order_items order_items_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);
 O   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_order_id_fkey;
       public               postgres    false    221    223    4768            �           2606    18573    orders orders_user_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_user_id_fkey;
       public               postgres    false    223    231    4780            �           2606    18578 )   transactions transactions_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 S   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_created_by_fkey;
       public               postgres    false    229    4780    231            D   �   x�-�A� E��)zp:z&����b�B���bl����7p�%A������
5��;��*��u��a���a����r�Y��h<��8��l�\`/s���O\��j\�e��k��2#�g��E�7Ġ�_��&�      F   �   x����j�0��~��]���2h3
����5udp�1��K�w0�Y�'K�t�K�=�D�^J��FFs�#qB��?&k)i���Fͭ����ǋ�j���dn(NK#ؾ�>�Ʉ�(J�[QL��y�#�חꬲ�Ւ�����yJ��\�=�G��aZn3�0�r%�+�z�3�A�����"��c^ܽ\��f���|��c�Y���6jn\�c����aC���TU�[q�      H      x������ � �      J      x������ � �      L   �  x���Ao�8����}���pt�il�v�
�vo�ĩ��w�8�D�(P��E~��y����w��`�
����>_Ϯ�?�~r���>� ��'*>�{:|{H����O_�?�w���=���p��=;�l���K����� ���î{�W��������r���
r��#{rv�2r�!�+���a�ߒ+�\��V��"�VfF�sf�Ψ0?n���%��.��V�Bm�4s�X�#fj�Q�@��i�fXԃ�A�8�K襊�
-Q��Z2t�A�z�nvj�5��F]��e��:5ڀ��R#dWױw�c�Г5,^���.�f��'4��ؘ�e�-��&=���0p��G*�.���h�Q�iL����G��ކ�;#b-��XQ[k�z���������V�2�"���p�~�����F�:7�"�㌸���� ����N+��p9���z,�<���tU}n�5���2w����t�p�G4��I����3��=t|},�M�c�o��rh���m��T�Fp�7"�M9��s��ٷ�N�ֈ=h�E3��ϐ�j#���l22��\��G��[piP8g���B]���,��x��i]�.��Ƶΐa ��>���u]m#�NX�r����L�Lm�i/���!+t���x�]��܂�0Ē۽r�x���t�~7ܭ���ۥ��$�~ӊ�T��i<�ج��;o�:ދ��"�2�!q�V�R�����yN֍2F�ڂN�޲�/ ����6�s�A ���Jf�m�3��R��!Еc�\��̖��S�q�r���q���gkd�����Q-0�������A�a�/fOے�f�~:@p�yDn�Jˀ`5����5.;pJK������O_�a�x\R�x5� �~hʛ��eu�«�<tQ@*����>h�Mx?��j�?�৖      N   	  x����j�0���y wI֯���е���˟�[�UQ)��w�BAz�&�$0���DS���D*�~���-���D��b�#:��(�D�t����q���p�����⸹���ў����i���C�Q��+���a �uƋ��bI�33TY����-��mzX٫B�ٱ�����φz�-�+;�'�hF+�oNSc4�m��q��z��A�][�2O�u9�׈<������	�w(I阋���L�����>A�1�      P   �  x��Z[o�F}���}t�����ov
4E��uR|@ї�M۴eʥ��ί�f)�oKJp� /�9;�3��V��ߗ�Xg˪?	c������~�i��,�*��B0�΅���¤�'Ҁ��o�7�?�:+V�u�;�Ư�C��̦J�`�9�����Y=g�j�W��W��K_P�@?�g_�_Wϫ���;��O���D+���BD�ڦ�-�[�������T��"�W~�L?o����~����o�ה��VwwYF??�^�u���*�ƴ�Q��=,��̖9��/WE�N�ւ� S�+��[� "t}k��;���ϟ��;���68fw����/~�������]V��9�L��R�aV�2�BD�=/�Ǣq���j����9[vb���0}�>o�������q'��B�����?3�h�
��R1��pM���$^v./��N�{�Z��|S���1+��/~�_���x�EN���2?�*63�q�:���m�����e�ɝ2]��!"�v	���?����b��~�<�����fu�y������	h	�E!"���,\i�}��]�:U2qNQ��Z�mB��P.��2�����q���ҫe�f9�]���J�͌�1��F �%y������q�x;цA2�l"�������ww��T��H���BD�}����*�c��+L�ٮ���.���O����0���`��RE!�X_�o�?�7�(�X�����:���e��W�	7PlJ��8e9�(DT3��Ŀ��=&�`��vo�&4sBF!�ޡ)�t�ՔcBV��p�e "J�Jӳ��N���$�[~س ��}����N9�:�J�Q��zԔl,�.���~=�L��+�i&��뉲���Q��9� �p��O)��e�b������YJY�	{�M�B�(D��d��9'�f[N����;�"Lo�ٖB@D���ƴ������ FЉ(D��<��t�*�c��{����

���URG!|z)ݑ>�BP���mpqpQ���!Ӈx|�|���\B��	�1W !
8FM"ݱ�m�N��â61�ȃj�������>)pq� ]Rm�@�#R���v{������ UfY��86Q����g����e�yi�#cBk6�0Q����g�Eo��Vme!Й�ۯ^�-޾vGIl�2�,�:��~��֘����{�펩��ke̡� �?���1���G���̼C�M�V�9�:T�}��HJM��ᔊBD��x<�~x{��.̙n���b���-���
�	��J*� D�1�w���xNj�M�6Dt32��u�"y���ۘ��vT�#Ǉ��jj��1Ta���9�
hCD73�h�~|�ܨ{����S�w0�X	��(D�1]od��j���U�R%Q�&����0D��ۼl5�G�-����� 6sܩ�pLG!bd�@e�?Vc�s�����9fhqh_1�1v�&�9!�1'}3��C�C��̶.
36r��w�4S}�D'C�1��!;3�ү���a��RG!b������{�\/��|��Jw]ކ�i�wt������(4�����e1�V�AH˦y��rz�X�L��uy� ID#�����÷�<�������=>@��[�!6V��c�T/�Y6��%�Z8lO}U;HW��)[n}y��e�Fz��l_��&E��2�_���;0��ˉ��<���Tb���b��� mAJ0�D.��x�P�pS����$�4	�O""���p�#с�5�,����P�I\��C���Ǐ��ʕ/��,Ǿ��0/����b��a��<qVql��c>�L�/������R4�K2!�c��aJ����թ�K�1�����JD�G���<� ��?�ѕ'PR5M��=�(ܧdA3�E�K7;U��_}�Y�W)9
�ƥ�1�b�$&���D��      R   �  x�uѻ��@���`�m�B�@4��: rQk�QDA���/�U��l���|u��?m��9�5��R���?������rc�^>�V`�o�ɲ���iP�Ku8jKաAK+�(��CL�.ZR�h��,a�e��Qi���fo��Ĝ�2�f���^]��b�J�#��[>��.w���!�CH�PGаB�`�������
,�}��S#�н�6�(sǳ�e��㯱�b����\�7���cAY���*c��
��Z����
�� h�I�9߶aP�]��雋�9�����y���M��=`I�W»���:�tH A*�5Q����^�]{{n�����ծ����t8?�3��-av���<��(H�A�wg��DD�&���T����GJdz׍u:3�:�N��&�u)�Y���J�6�|���z]E�uSܕ�?�/��L�B+�V���ޙ���9�cb��7���-��J����!h����(� �F��     