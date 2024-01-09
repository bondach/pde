{ javaPlatform }:
f: p:

{
  jdk = p.${javaPlatform};
  jre = p.${javaPlatform};
}
