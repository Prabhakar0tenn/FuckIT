/*Copyright © SLT Softwares. All rights reserved.
Use of this source code is governed by a GNU license that can be found in the LICENSE file.*/

using System.Net.Http;

namespace SLBr
{
    public static class HttpClientFactory
    {
        public static HttpClient Create(SocketsHttpHandler SocketsHandler, TimeSpan? _Timeout = null)
        {
            SocketsHandler.EnableMultipleHttp3Connections = false;
            SocketsHandler.EnableMultipleHttp2Connections = false;
            HttpClient Client = new(SocketsHandler)
            {
                DefaultVersionPolicy = HttpVersionPolicy.RequestVersionOrHigher
            };
            if (_Timeout.HasValue)
                Client.Timeout = _Timeout.Value;
            return Client;
        }
    }
}
