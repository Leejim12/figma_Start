
if ( document.location.protocol.toLowerCase() == 'https:' )
{
	document.write( '<scr' + 'ipt src ="https://ssl.nexon.com/s1/global/ngb_RSAHash.js" type="text/javascript"></scr' + 'ipt>' );
}
else
{
	document.write( '<scr' + 'ipt src ="http://js.nexon.com/s1/global/ngb_RSAHash.js" type="text/javascript"></scr' + 'ipt>' );
}

window.addEventListener('message', function (e) {
    var strDomain = 'https://' + NgbLogin.GetLoginURL();

    if (e.origin !== strDomain
        && e.origin !== 'https://login.nexon.com')
        return;
    
    var data = e.data;

    if (data.type == 'logincallback') {
        if (data.response == undefined || window[data.callback] == undefined) return;

        window[data.callback](data.response);
    }
});

var NgbSecurity = new function __NgbSecurity()
{
    var _retryCount = 0;
	var _e;
	var _m;
	var _hash;
	var _handler;
	var _url;
	var _message;
	var _errormessage;
	var _timer;
	var _timeout;
	var _header;
	var _WO71R7A8QGVBHR3V = new Array();

	this.InitData = function()
	{
		if ( typeof( _url ) != 'undefined' && typeof( _timer ) != 'undefined' )
			return;
		
		_WO71R7A8QGVBHR3V.length = 0;
	}
	
	this.AddData = function( _T1UP73S9YGYXF4SB )
	{
		if ( typeof( _url ) != 'undefined' && typeof( _timer ) != 'undefined' )
			return;
			
		_WO71R7A8QGVBHR3V[ _WO71R7A8QGVBHR3V.length ] = _T1UP73S9YGYXF4SB;
	}
	
	this.SetURL = function( url, message, errormessage )
	{
		_url = url;
		_message = message;
		_errormessage = errormessage;
	}
	
	this.SetTimeout = function( timeout )
	{
		_timeout = timeout;
	}
	
	this.SetEncryptInfo = function( e, m, hash )
	{
		_e = e;
		_m = m;
		_hash = hash;
	}
	
	this.Encrypt = function( handler )
	{
		if ( _WO71R7A8QGVBHR3V.length == 0 || typeof( handler ) == 'undefined' )
			throw Exception;
			
		_handler = handler;
		
		if ( typeof( _url ) != 'undefined' )
		{
			if ( typeof( _timer ) != 'undefined' )
			{
				if ( typeof( _message ) != 'undefined' )
					alert( _message );
				else
					alert( '요청을 처리중입니다.' );

				return;
			}
			
			if ( typeof( _timeout ) != 'undefined' )
				_timer = setTimeout( 'NgbSecurity.ExpireRequest()',_timeout );
			else
				_timer = setTimeout( 'NgbSecurity.ExpireRequest()', 10000 );
			
			AppendScript( _url );
		}
		else
		{
			if ( typeof( _e ) == 'undefined' || typeof( _m ) == 'undefined' )
				throw Exception;
			
			ProcessEncrypt();
		}
	}
	
	this.ExpireRequest = function()
	{
		clearTimeout( _timer );
		_timer = undefined;

		_WO71R7A8QGVBHR3V.length = 0;
		
		if ( typeof( _errormessage ) != 'undefined' ) {
			alert( _errormessage );
        }
		else {
            _retryCount = _retryCount + 1;
            if( _retryCount < 3 ) {
			    alert( '요청 시간이 초과되었습니다.' );
            }
            else {
                alert('사용자 네트워크 연결 상태가 불안정하거나, 부정적인 접근 시도가 감지된 환경일수 있습니다.\r\n넥슨 고객센터로 문의해주세요');
            }
        }
	}
	
	this.HandleResponse = function( responseXML )
	{
		if ( typeof( _timer ) != 'undefined' )
		{
			clearTimeout( _timer );
			_timer = undefined;
		
			var resultObject = NxamlParser.ParseXmlText( responseXML );
			EncryptHandler( responseXML, resultObject );
		}
	}
	
	this.HashString = function( _BFNXO2Q9N1QLW4VB )
	{
		var hashString = NgbHash.HMAC_SHA256_MAC2( "4E65786F6E55736572", _BFNXO2Q9N1QLW4VB );
		return hashString;
	}
	
	this.HashString2 = function( _S3VK2NSVI6EN11SU, _BFNXO2Q9N1QLW4VB, _RENIQJVGHWDP1KES )
	{
		var hashString = _S3VK2NSVI6EN11SU + NgbHash.HMAC_SHA256_MAC( _RENIQJVGHWDP1KES, NgbHash.HMAC_SHA256_MAC2( "4E65786F6E55736572", _BFNXO2Q9N1QLW4VB ));
		return hashString;
	}
	
	var AppendScript = function( src )
	{
		var script = document.createElement( 'script' );
		
		script.src = src;
		script.type = 'text/javascript';
		script.charset = 'ks_c_5601-1987';
	
		document.getElementsByTagName( 'head' )[ 0 ].appendChild( script );
	}
	
	var ProcessEncrypt = function()
	{
		setMaxDigits( 131 );
		
		var key = new NgbRSA.RSAKeyPair( _e, '', _m );
		var _T1UP73S9YGYXF4SB = '';
		
		if ( typeof( _hash ) != 'undefined' )
			_T1UP73S9YGYXF4SB = _hash + '\\';
			
		for ( var i = 0; i < _WO71R7A8QGVBHR3V.length; i++ )
		{
			_T1UP73S9YGYXF4SB += NgbRSA.utf8base64encode( _WO71R7A8QGVBHR3V[ i ] );
			
			if ( i < _WO71R7A8QGVBHR3V.length - 1 )
				_T1UP73S9YGYXF4SB += '\\';
		}
		
		var val = EncryptString( key, _T1UP73S9YGYXF4SB );
		_WO71R7A8QGVBHR3V.length = 0;
		
		_handler( val );
	}
	
	var EncryptHandler = function( responseXML, resultObject )
	{
		if ( typeof( resultObject.result.e ) != 'undefined' 
			&& typeof( resultObject.result.m ) != 'undefined' 
			&& typeof( resultObject.result.h ) != 'undefined' )
		{
			_e = resultObject.result.e;
			_m = resultObject.result.m;
			_hash = resultObject.result.h;
			
			ProcessEncrypt();
		}
		else
		{
			alert( "로그인 처리과정 중 오류가 발생하였습니다." );
			return;
		}
	}
	
	var EncryptString = function( key, _J2N45M9LEMBV1U4P )
	{
		if ( key.chunkSize > key.digitSize - 11 )
		{
			return 'Error';
		}
		
		var a = new Array();
		var sl = _J2N45M9LEMBV1U4P.length;
		
		var i = 0;
		while ( i < sl )
		{
			a[ i ] = _J2N45M9LEMBV1U4P.charCodeAt( i );
			i++;
		}
		
		var al = a.length;
		var result = '';
		var j, k, block;
		for ( i = 0; i < al; i += key.chunkSize )
		{
			block = new BigInt();
			j = 0;
			var x;
			var msgLength = ( i + key.chunkSize ) > al ? al % key.chunkSize : key.chunkSize;
			
			var b = new Array();
			for ( x = 0; x < msgLength; x++ )
			{
				b[ x ] = a[ i + msgLength - 1 - x ];
			}
			b[ msgLength ] = 0;
			var paddedSize = Math.max( 8, key.digitSize - 3 - msgLength );
		
			for ( x = 0; x < paddedSize; x++ )
			{
				b[ msgLength + 1 + x ] = Math.floor(Math.random() * 254) + 1;
			}
			b[ key.digitSize - 2 ] = 2;
			b[ key.digitSize - 1 ] = 0;
			
			for ( k = 0; k < key.digitSize; ++j )
			{
				block.digits[ j ] = b[ k++ ];
				block.digits[ j ] += b[ k++ ] << 8;
			}

			var crypt = key.barrett.powMod( block, key.e );
			var text = key.radix == 16 ? biToHex( crypt ) : biToString( crypt, key.radix );
			result += text + ' ';
		}
		
		return result.substring( 0, result.length - 1 );
	}
}

var NgbLogin = new function __NgbLogin()
{
	var _isLoginProcessing = false;
	var _retryCount = 0;
	var _accesscode = 0;
	var _strRedirect;
	var _header;
	var _hashKey;
	var __J8GUIRG2CT36ALSM;
	var __EEMXGHI304W1IAJK;
	var _isLogin2;
	var _callBackMethod;
	var _isKeepLogin = '0';
	
	var _hashtimer;
	
	var _PHFYQ3ENXE3SXJYN;
	
	var _isInvalidPasswordHashKeyString = false;
    var _isFailover = false;
    var _isSLogin = '0';
	
	this.SetData = function( _J8GUIRG2CT36ALSM, _EEMXGHI304W1IAJK, accesscode, strRedirect, isSLogin )
	{
		__J8GUIRG2CT36ALSM = _J8GUIRG2CT36ALSM;
		__EEMXGHI304W1IAJK = _EEMXGHI304W1IAJK;
		_accesscode = accesscode;
		_strRedirect = strRedirect;
        _isSLogin = isSLogin;
	}
	
    this.SetKeepLogin = function ( isKeeplogin )
    {
        _isKeepLogin = isKeeplogin;
    }	

	this.InitLoginProcessing = function()
	{
		_isLoginProcessing = false;
	}
	
	this.SubmitLogin = function()
	{
		var strDomain = NgbLogin.GetLoginURL();
		var strEncData = arguments [ 1 ][ 0 ];
        var strAccesscode = arguments [ 1 ][ 1 ];
		var strRedirect = arguments [ 1 ][ 2 ];
        var isLogin2 = arguments [ 1 ][ 3 ];
        var strCallBackMethod = arguments [ 1 ][ 4 ];
        var isSLogin = arguments[1][5];

		if ( strEncData == 'Error' )
		{
			alert( "로그인 처리과정 중 오류가 발생하였습니다." );
			return false;
		}
		
		if ( _isLoginProcessing )
		{
			alert( "로그인 하는 중입니다. 잠시만 기다려주세요." );
			return false;
		}
		_isLoginProcessing = true;
		
		if( isLogin2 == false )
		{		
			NgbClientForm.AddChildForSubform( 'strEncData', strEncData );
            NgbClientForm.AddChildForSubform( 'strAccesscode', strAccesscode );
            NgbClientForm.AddChildForSubform( 'isSLogin', isSLogin );
			
            NgbClientForm.AddChildForSubform( 'isKeepLogin', _isKeepLogin);

			if ( typeof( strRedirect ) != 'undefined' )
				NgbClientForm.AddChildForSubform( 'strRedirect', strRedirect );
            else
                NgbClientForm.AddChildForSubform( 'strRedirect', escape( document.location.href ) );
				
			NgbClientForm.SubmitForm( 'https://' + strDomain + '/login/page/loginproc.aspx' );
		}
		else
		{
			var iframe;
			
			try
			{
				iframe = document.createElement( "<iframe name='iframe1' />" );
			} catch ( ex ) {
				iframe = document.createElement( "iframe" );
				iframe.name = "iframe1";
			}
			
			iframe.src = "javascript:'<script>window.onload=function(){document.write(document.close();};<\/script>'";
			iframe.style.display = "none";
			document.body.appendChild( iframe ); 

			var encData = document.createElement( "input" );
			encData.setAttribute( "type", "hidden" );
			encData.setAttribute( "name", "strEncData" );
			encData.setAttribute( "value", strEncData );
			
            var accesscode = document.createElement("input");
            accesscode.setAttribute("type", "hidden");
            accesscode.setAttribute("name", "strAccesscode");
            accesscode.setAttribute("value", strAccesscode);

			var callBackMethod = document.createElement( "input" );
			callBackMethod.setAttribute( "type", "hidden" );
			callBackMethod.setAttribute( "name", "strCallBackMethod" );
            callBackMethod.setAttribute("value", strCallBackMethod);

            var origin = document.createElement("input");
            origin.setAttribute("type", "hidden");
            origin.setAttribute("name", "strPostMessageOrigin");
            origin.setAttribute("value", document.location.origin);

			var form = document.createElement( "form" );
			form.method = "post";
			form.target = "iframe1";
			form.action = "https://" + strDomain + "/login/page/loginproc2.aspx";
            form.appendChild(encData);
            form.appendChild( accesscode );
            form.appendChild(callBackMethod);
            form.appendChild(origin);

			document.body.appendChild( form );
			
			NgbLogin.PollSubmit( form );
		}
	}
	
	this.PollSubmit = function( form )
	{
		try
		{
			form.submit();
		}
		catch( e )
		{
			setTimeout(function() { // set a timeout to give browsers a chance to recognize the <iframe> 
				NgbLogin.PollSubmit( form );
			}, 100 );
		}
	}

    this.SLogin = function (_J8GUIRG2CT36ALSM, _EEMXGHI304W1IAJK, accesscode, strRedirect) {
        NgbLogin.SetData(_J8GUIRG2CT36ALSM, _EEMXGHI304W1IAJK, accesscode, strRedirect, '1');
        _isLogin2 = false;

        if (_J8GUIRG2CT36ALSM.indexOf('@') != -1 )
        {
            var arrEmail = _J8GUIRG2CT36ALSM.split('@');

            if (arrEmail.length != 2 || arrEmail[0] == '' || arrEmail[1] == '' || _J8GUIRG2CT36ALSM.indexOf(' ') != -1 )
            {
                alert('아이디를 확인해 주세요.');
                return;
            }

            if (typeof (_hashtimer) != 'undefined') {
                alert('로그인 하는 중입니다. 잠시만 기다려주세요.');
                return;
            }

            _isFailover = false;
            _PHFYQ3ENXE3SXJYN = _J8GUIRG2CT36ALSM;
            AuthSystem.GetPasswordHashKey(_J8GUIRG2CT36ALSM, NgbLogin.HashHandler);

            _hashtimer = setTimeout('NgbLogin.ExpireHashProcess()', 5000);
        }
		else
        {
            NgbLogin.MemberLogin();
        }
	}

    this.Login = function (_J8GUIRG2CT36ALSM, _EEMXGHI304W1IAJK, accesscode, strRedirect)
	{
		NgbLogin.SetData( _J8GUIRG2CT36ALSM, _EEMXGHI304W1IAJK, accesscode, strRedirect);
		_isLogin2 = false;
		
		if ( _J8GUIRG2CT36ALSM.indexOf( '@' ) != -1 )
		{
			var arrEmail = _J8GUIRG2CT36ALSM.split( '@' );
			
			if ( arrEmail.length != 2 || arrEmail[ 0 ] == '' || arrEmail[ 1 ] == '' || _J8GUIRG2CT36ALSM.indexOf( ' ' ) != -1 )
			{
				alert( '아이디를 확인해 주세요.' );
				return;
			}
			
			if ( typeof( _hashtimer ) != 'undefined' )
			{
				alert( '로그인 하는 중입니다. 잠시만 기다려주세요.' );
				return;
			}
			
			_isFailover = false;
			_PHFYQ3ENXE3SXJYN = _J8GUIRG2CT36ALSM;
			AuthSystem.GetPasswordHashKey( _J8GUIRG2CT36ALSM, NgbLogin.HashHandler );
			
			_hashtimer = setTimeout( 'NgbLogin.ExpireHashProcess()', 5000 );
		}
		else
		{
			NgbLogin.MemberLogin();
		}
	}
	
	this.Login2 = function( _J8GUIRG2CT36ALSM, _EEMXGHI304W1IAJK, callBackMethod, accesscode )
	{
		if( typeof( callBackMethod ) == "undefined" || callBackMethod == "" )
		{
			alert( "로그인 처리과정 중 오류가 발생하였습니다." );
			return;
		}

        NgbLogin.SetData(_J8GUIRG2CT36ALSM, _EEMXGHI304W1IAJK, accesscode);
		_isLogin2 = true;
		_callBackMethod = callBackMethod;
		
		if ( _J8GUIRG2CT36ALSM.indexOf( '@' ) != -1 )
		{
			var arrEmail = _J8GUIRG2CT36ALSM.split( '@' );
			
			if ( arrEmail.length != 2 || arrEmail[ 0 ] == '' || arrEmail[ 1 ] == '' )
			{
				alert( '아이디를 확인해 주세요.' );
				return;
			}
			
			if ( typeof( _hashtimer ) != 'undefined' )
			{
				alert( '로그인 하는 중입니다. 잠시만 기다려주세요.' );
				return;
			}
			
			_isFailover = false;
			_PHFYQ3ENXE3SXJYN = _J8GUIRG2CT36ALSM;
			AuthSystem.GetPasswordHashKey( _J8GUIRG2CT36ALSM, NgbLogin.HashHandler );
			
			_hashtimer = setTimeout( 'NgbLogin.ExpireHashProcess()', 5000 );
		}
		else
		{
			NgbLogin.MemberLogin();
		}
	}
	
	this.ExpireHashProcess = function()
	{
		clearTimeout( _hashtimer );
		_hashtimer = undefined;
		_retryCount = _retryCount + 1;
        if( _retryCount < 3 ) {
			alert( '요청 시간이 초과되었습니다.' );
        }
        else {
            alert('사용자 네트워크 연결 상태가 불안정하거나, 부정적인 접근 시도가 감지된 환경일수 있습니다.\r\n넥슨 고객센터로 문의해주세요');
        }
	}
	
	this.MemberLogin = function()
	{
		_J8GUIRG2CT36ALSM = __J8GUIRG2CT36ALSM;
		_EEMXGHI304W1IAJK = __EEMXGHI304W1IAJK;
		accesscode = _accesscode;
		strRedirect = _strRedirect;
        isSLogin = _isSLogin;
		
		var strDomain = NgbLogin.GetLoginURL();
		_J8GUIRG2CT36ALSM = NgbString.Trim( _J8GUIRG2CT36ALSM );
		_EEMXGHI304W1IAJK = NgbString.Trim( _EEMXGHI304W1IAJK );
		
		if ( typeof( accesscode ) == 'undefined' )
			accesscode = 0;
			
        if (typeof (isSLogin) == 'undefined')
            isSLogin = '0';
			
		if ( _J8GUIRG2CT36ALSM == '' || _J8GUIRG2CT36ALSM.indexOf( ' ' ) != -1 )
		{
			alert( '아이디를 입력해 주세요.' );
			return;
		}
		else if ( _EEMXGHI304W1IAJK == '' )
		{
			alert( '비밀번호를 입력해 주세요.' );
			return;
		}
		
		_accesscode = accesscode;
		_strRedirect = strRedirect;
        _isSLogin = isSLogin;
		
		try
		{
			NgbSecurity.InitData();
			
			NgbSecurity.AddData( _J8GUIRG2CT36ALSM );
			NgbSecurity.AddData( _J8GUIRG2CT36ALSM.indexOf( '@' ) != -1 ? NgbSecurity.HashString2( _header, _EEMXGHI304W1IAJK, _hashKey ) : _EEMXGHI304W1IAJK );
            NgbSecurity.AddData( NgbHash.SHA256_hash(_EEMXGHI304W1IAJK));
			NgbSecurity.SetURL( 'https://' + strDomain + '/login/page/encryptinfo.aspx', '로그인 하는 중입니다. 잠시만 기다려주세요.' );
			NgbSecurity.Encrypt( NgbLogin.EncryptHandler );
		}
		catch( e )
		{
            NgbEVM.AddCommand(NgbEVM.k_nEventType_onPageEnd, new NgbEVMDelegator(NgbLogin.SubmitLogin), '', _accesscode, _strRedirect, _isLogin2, _callBackMethod, _isSLogin);
		}
	}
	
	this.EncryptHandler = function( encData )
	{
        NgbEVM.AddCommand(NgbEVM.k_nEventType_onPageEnd, new NgbEVMDelegator(NgbLogin.SubmitLogin), encData, _accesscode, _strRedirect, _isLogin2, _callBackMethod, _isSLogin);
	}

	this.Logout = function( strURL )
	{
		var strDomain = NgbLogin.GetLoginURL();
	
		if ( typeof( strURL ) == 'undefined' )
			strURL = document.location.href;
		
		document.location.href = 'https://' + strDomain + '/login/page/logout.aspx?redirect=' + escape( strURL );
	}
	
	this.GetLoginURL = function()
	{
		var strDomain;
		
		try
		{
			strDomain = NgbUrl.GetDomainURL();
		}
		catch ( e )
		{
			strDomain = 'login.nexon.com';
		}
		
		switch ( strDomain )
		{
			case 'df.nexon.com' : 
			case 'dflogin.nexon.com' : 
				return 'dflogin.nexon.com';
				
			default : 
				return 'login.nexon.com';
		}
	}

    this.LoginTPA = function( strRedirect, action, authlevel, accesscode, isSLogin )
	{
		var strDomain = NgbLogin.GetLoginURL();
	
        if (typeof (strRedirect) == 'undefined' || !strRedirect)
			strRedirect =  document.location.href;

        var url = 'https://' + strDomain + '/login/' + action + '?redirect=' + escape(strRedirect);

        if (typeof (authlevel) != 'undefined' && authlevel == "1") {
            url += "&authlevel=1";
        }        
        if (typeof (accesscode) != 'undefined' && accesscode != "") {
            url += "&accesscode=" + accesscode;
        }

        if (typeof (isSLogin) != 'undefined' && isSLogin == "1") {
            url += "&isSLogin=1";
        }   
         
        document.location.href = url;
	}	

    this.LoginFacebook = function( strRedirect, authlevel , accesscode)
	{
        NgbLogin.LoginTPA(strRedirect, 'facebook', authlevel, accesscode);
	}

    this.LoginGoogle = function( strRedirect, authlevel , accesscode)
	{
        NgbLogin.LoginTPA(strRedirect, 'google', authlevel, accesscode);
	}	

    this.LoginNaver = function( strRedirect, authlevel, accesscode)
	{
        NgbLogin.LoginTPA(strRedirect, 'naver', authlevel, accesscode);
}	

    this.LoginApple = function (strRedirect, authlevel, accesscode) {
        NgbLogin.LoginTPA(strRedirect, 'apple', authlevel, accesscode);
    }	

    this.SLoginFacebook = function (strRedirect, authlevel, accesscode) {
        NgbLogin.LoginTPA(strRedirect, 'facebook', authlevel, accesscode, '1');
    }

    this.SLoginGoogle = function (strRedirect, authlevel, accesscode) {
        NgbLogin.LoginTPA(strRedirect, 'google', authlevel, accesscode, '1');
    }

    this.SLoginNaver = function (strRedirect, authlevel, accesscode) {
        NgbLogin.LoginTPA(strRedirect, 'naver', authlevel, accesscode, '1');
    }	

    this.SLoginApple = function (strRedirect, authlevel, accesscode) {
        NgbLogin.LoginTPA(strRedirect, 'apple', authlevel, accesscode, '1');
    }	

	this.HashHandler = function( resultObject, responseXML )
	{
		try
		{
			clearTimeout( _hashtimer );
			_hashtimer = undefined;
		
			if ( typeof( resultObject.PasswordHashKeyString ) != 'undefined' && resultObject.PasswordHashKeyString != '' )
			{
				var result = resultObject.PasswordHashKeyString;
				var info = result.split(':');
				_header = info[0] + ':' + info[1] + ':' + info[2] + ':';
				_hashKey = info[3];
				
				_isInvalidPasswordHashKeyString = false;
			}
			else
			{
				_isInvalidPasswordHashKeyString = true;
			}
		}
		catch ( e )
		{
			_isInvalidPasswordHashKeyString = true;
		}
		
		if ( _isInvalidPasswordHashKeyString == true )
		{
			alert( "로그인 처리과정 중 오류가 발생하였습니다." );
			return;
		}
		else
		{
			NgbLogin.MemberLogin();
		}
	}
}
