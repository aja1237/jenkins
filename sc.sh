#!/bin/bash

clear
echo -e "\e[42m\e[1m\e[5m\e[30m################################################################\e[0m"
echo -e "\e[42m\e[1m\e[5m\e[30m### This script controls the  Togocel POC environemnt Services##\e[0m"
echo -e "\e[42m\e[1m\e[5m\e[30m### Owning Group :- MFS INFRA                                ###\e[0m"
echo -e "\e[42m\e[1m\e[5m\e[30m################################################################\e[0m"

export JAVA_HOME=/usr/

function service_control_fn ()
{

    while true;
    do
    echo -e "  \t\n \e[92mYou have selected the $OPERATN operation, please select the service from below list which you want to $OPERATN \n"
    echo -e "  \t 1. BRM Service - Engine node "
    echo -e "  \t 2. Umarket - Engine node "
    echo -e "  \t 3. Uview - Engine node "
    echo -e "  \t 4. Ldap - Engine node "
    echo -e "  \t 5. BPM BUS Service - Connector/MobileApp node "
    echo -e "  \t 6. Gateway - Connector/MobileApp node "
    echo -e "  \t 7. Oauth2 - Only on MobileApp node "
    echo -e "  \t 8. Liferay - Web node"
 #   echo -e "  \t 9. ETL - Only for Silo2  \e[0m\n"
    echo -e "  \t 9. Exit. \e[0m\n"
    read service_name
    echo -e " \t You have selected the $service_name service to $OPERATN  \n"
      case $service_name in
        1)
          echo -e " \t Performing $OPERATN operation - brm service on $ENG_NODE Engine node \n"
          ssh infraadm@$ENG_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/brm.sh $OPERATN ; chmod -R 755 /app/utiba/*"
          ;;
        2)
          echo -e " \t Performing $OPERATN operation - Umarket service on $ENG_NODE Engine node\n"
          ssh infraadm@$ENG_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/utibactl.bash $OPERATN $um_serv ; chmod -R 755 /app/utiba/*"
          ;;
        3)
          echo -e " \t Performing $OPERATN operation - Uview service on $ENG_NODE Engine node\n"
          ssh infraadm@$ENG_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/utibactl.bash $OPERATN $uv_serv ; chmod -R 755 /app/utiba/*"
          ;;
        4)
          echo -e " \t Performing $OPERATN operation - Ldap service on $ENG_NODE Engine node\n"
          ssh infraadm@$ENG_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/utibactl.bash $OPERATN $ldap_serv ; chmod -R 755 /app/utiba/*"
          ;;
        5)
          echo -e " \t Performing $OPERATN operation - BPM service on $CONN_NODE  node\n"
          ssh infraadm@$CONN_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/bpm.sh $OPERATN ; chmod -R 755 /app/utiba/*"
          ;;
        6)
          echo -e " \t Performing $OPERATN operation - Gateway service on $CONN_NODE node\n"
          ssh infraadm@$CONN_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/gateway.sh $OPERATN ; chmod -R 755 /app/utiba/*"
          ;;
        7)
          echo -e " \t Performing $OPERATN operation - Oauth2 service on $CONN_NODE node\n"
          ssh infraadm@$CONN_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/oauth2.sh $OPERATN ; chmod -R 755 /app/utiba/*"
          ;;
        8)
          echo -e " \t Performing $OPERATN operation - Liferay Service on $WEB_NODE web node\n"
          ssh infraadm@$WEB_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/liferay.sh $OPERATN ; chmod -R 755 /app/utiba/*"
          ;;
#        9)
#          if [[ $SILO == 2 ]]
#          then
#                if [[ $OPERATN == check ]]
#                then
#                        OPERATN=status
#                        echo -e " \t Performing $OPERATN operation - ETL Service on $ETL_NODE web node\n"
       #                 ssh infraadm@$ETL_NODE "export JAVA_HOME=/usr;/bin/bash /app/utiba/uaccess/bin/uaccess_infra.sh $OPERATN"
#                else
#                        echo -e " \t Performing $OPERATN operation - ETL Service on $ETL_NODE web node\n"
      #                  ssh infraadm@$ETL_NODE "export JAVA_HOME=/usr;nohup /bin/bash /app/utiba/uaccess/bin/uaccess_infra.sh $OPERATN > /dev/null 2>&1 </dev/null &"
#                fi
#          else
#                echo -e "\t $ETL_NODE is not the the part of SILO1, ETL service is only for SILO2 nodes\n"
#          fi
#          ;;
        9)
          exit 1
          ;;
        *)
          echo -e " \t Please select the service from above list only... EXITING..... "
          break
          ;;
       esac
    done
}

function all_service_fn ()
{
          echo -e "  \t\n \e[91m You have selected the operation to $OPERATN the all services on $ENG_NODE $CONN_NODE $WEB_NODE of SILO $SILO, Please select yes/no to proceed "
          echo -e " \t 1. Yes "
          echo -e " \t 2. No \e[0m"
          read all_service_operation
#         echo -e " \t You have selected $all_service_operation to proceed wuth $OPERATN all service option... \n"
          case $all_service_operation in
                1)
                        echo -e " \t Performing $OPERATN operation on all the services as per below sequence. "
                        echo -e " \t 1)BRMS Service 2)BPM Bus 3)Oauth 4)Gateway 5)Umarket 6)LDAP 7)UVIEW 8)liferay "

                        echo -e " \n\t Performing $OPERATN operation - BRMS Service on $ENG_NODE........."
                        ssh infraadm@$ENG_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/brm.sh $OPERATN"
                        sleep 10

                        echo -e " \n\t Performing $OPERATN operation - bpm bus on $CONN_NODE........."
                        ssh infraadm@$CONN_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/bpm.sh $OPERATN"
                        sleep 10

                        echo -e " \n\t Performing $OPERATN operation - Oauth on $CONN_NODE........."
                        ssh infraadm@$CONN_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/oauth2.sh $OPERATN"
                        sleep 10

                        echo -e " \n\t Performing $OPERATN operation - gateway on $CONN_NODE........."
                        ssh infraadm@$CONN_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/gateway.sh $OPERATN"
                        sleep 10
                        ssh infraadm@$CONN_NODE "chmod -R 755 /app/utiba/*"


                        echo -e " \n\t Performing $OPERATN operation - Umarket on $ENG_NODE ........"
                        ssh infraadm@$ENG_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/utibactl.bash $OPERATN $um_serv"
                        sleep 10

                        echo -e " \n\t Performing $OPERATN operation - LDAP on $ENG_NODE........."
                        ssh infraadm@$ENG_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/utibactl.bash $OPERATN $ldap_serv"
                        sleep 10

                        echo -e " \n\t Performing $OPERATN operation - UView on $ENG_NODE........."
                        ssh infraadm@$ENG_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/utibactl.bash $OPERATN $uv_serv"
                        sleep 10
                        ssh infraadm@$ENG_NODE "chmod -R 755 /app/utiba/*"

                        echo -e " \n\t Performing $OPERATN operation - liferay on $WEB_NODE........."
                        ssh infraadm@$WEB_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/liferay.sh $OPERATN"
                        sleep 30
                        ssh infraadm@$WEB_NODE "chmod -R 755 /app/utiba/*"

#                        if [[ $SILO == 2 ]]
#                        then
#                        echo -e " \n\t Performing $OPERATN operation - ETL on $ETL_NODE........."
              #          ssh infraadm@$ETL_NODE "export JAVA_HOME=/usr;/app/utiba/uaccess/bin/uaccess_infra.sh $OPERATN"
#                        sleep 10
#                        fi

                        ;;

                2)
                        echo -e " \n\t You selected not to proceed with the $OPERATN all services... EXITING... "
                        break;
                        ;;
          esac
}

function all_check_service_fn ()
{

          echo -e "  \t\n \e[91m You have selected the operation to $OPERATN the all services on $ENG_NODE $CONN_NODE $WEB_NODE of SILO $SILO, Please select yes/no to proceed "
          echo -e " \t 1. Yes "
          echo -e " \t 2. No \e[0m"
          read all_service_operation
#         echo -e " \t You have selected $all_service_operation to proceed wuth $OPERATN all service option... \n"
          case $all_service_operation in
                1)
                        echo -e " \t Performing $OPERATN operation on all the services as per below sequence. "
                        echo -e " \t 1)BRMS Service 2)BPM Bus 3)Oauth 4)Gateway 5)Umarket 6)LDAP  7)UVIEW 8)liferay"

                        echo -e " \n\t Performing $OPERATN operation - BRMS Service on $ENG_NODE........."
                        ssh infraadm@$ENG_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/brm.sh $OPERATN"

                        echo -e " \n\t Performing $OPERATN operation - bpm bus on $CONN_NODE........."
                        ssh infraadm@$CONN_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/bpm.sh $OPERATN"

                        echo -e " \n\t Performing $OPERATN operation - Oauth on $CONN_NODE........."
                        ssh infraadm@$CONN_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/oauth2.sh $OPERATN"

                        echo -e " \n\t Performing $OPERATN operation - gateway on $CONN_NODE........."
                        ssh infraadm@$CONN_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/gateway.sh $OPERATN"

                        echo -e " \n\t Performing $OPERATN operation - Umarket on $ENG_NODE ........"
                        ssh infraadm@$ENG_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/utibactl.bash $OPERATN $um_serv"

                        echo -e " \n\t Performing $OPERATN operation - LDAP on $ENG_NODE........."
                        ssh infraadm@$ENG_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/utibactl.bash $OPERATN $ldap_serv"

                        echo -e " \n\t Performing $OPERATN operation - UView on $ENG_NODE........."
                        ssh infraadm@$ENG_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/utibactl.bash $OPERATN $uv_serv"

                        echo -e " \n\t Performing $OPERATN operation - liferay on $WEB_NODE........."
                        ssh infraadm@$WEB_NODE "export JAVA_HOME=/usr;/app/utiba/umarket/utils/liferay.sh $OPERATN"

#                        if [[ $SILO == 2 ]]
#                        then
#                        echo -e " \n\t Performing $OPERATN operation - ETL on $ETL_NODE........."
    #                    ssh infraadm@$ETL_NODE "export JAVA_HOME=/usr;/app/utiba/uaccess/bin/uaccess_infra.sh status"
#                        fi

                        ;;

                2)
                        echo -e " \n\t You selected not to proceed with the $OPERATN all services... EXITING... "
                        break;
                        ;;
          esac


}

while true
do
#echo -e " \n\t \e[41mPlease be cautious, you are runnning this script on SINGTEL SIT environemnt \e[0m\n"

echo -e " \n\t \e[36mPlease select the SILO from below list "
echo -e "  \t 1. POC"
#echo -e "  \t 2. SILO 2"
#echo -e "  \t 3. SILO 3"
#$echo -e "  \t 4. SILO 4"
echo -e "  \t 2. Exit\e[0m "

read SILO

        if [ $SILO == 1 ]
        then
                ENG_NODE=um-poc-eng-101
                CONN_NODE=um-poc-app-101
                WEB_NODE=um-poc-web-101
                um_serv=a-umarket_1
                uv_serv=a-uview_1
                ldap_serv=i-ldap_1
#        elif [ $SILO == 2 ]
#        then
#                ENG_NODE=SDPSITENGILS002.aws.sit.sg.singtelgroup.net
#                CONN_NODE=SDPSITCONILS001.aws.sit.sg.singtelgroup.net
#                WEB_NODE=SDPSITWEBILS002.aws.sit.sg.singtelgroup.net
#               ETL_NODE=SDPSITETLILS001.aws.sit.sg.singtelgroup.net
#               um_serv=a-umarket_2
#                uv_serv=a-uview_2
#                ldap_serv=i-ldap_2
        #elif [ $SILO == 3 ]
        #then
                #ENG_NODE=SDPUATENGILS003.aws.uat.sg.singtelgroup.net
                 #CONN_NODE=SDPUATCONILS001.aws.uat.sg.singtelgroup.net
                 #WEB_NODE=SDPUATWEBILS003.aws.uat.sg.singtelgroup.net
                 # #ETL_NODE=SDPUATETLILS001.aws.uat.sg.singtelgroup.net
                 #um_serv=a-umarket_3
                 #uv_serv=a-uview_3
                 #ldap_serv=i-ldap_3
        #elif [ $SILO == 4 ]
        #then
                #ENG_NODE=SDPUATENGILS004.aws.uat.sg.singtelgroup.net
                #CONN_NODE=SDPUATCONILS002.aws.uat.sg.singtelgroup.net
                #WEB_NODE=SDPUATWEBILS004.aws.uat.sg.singtelgroup.net
                #ETL_NODE=SDPUATETLILS002.aws.uat.sg.singtelgroup.net
                #um_serv=a-umarket_4
                #uv_serv=a-uview_4
                #ldap_serv=i-ldap_4
#       elif [ $SILO == 3 ]
#       then
#               break
        else
                echo " Please select the SILO from the specified list only......"
                break
        fi

echo -e " \n\t \e[96mPlease select the operation from below list "
echo -e "  \t 1. Start Service "
echo -e "  \t 2. Stop Service "
echo -e "  \t 3. Check Service "
echo -e "  \t 4. Restart Service "
echo -e "  \t 5. start all services on Engine, connector and web node "
echo -e "  \t 6. Stop all services on Engine, connector and web node "
echo -e "  \t 7. Check all services on Engine, connector and web node "
echo -e "  \t 8. Restart all services on Engine, connector and web node "
echo -e "  \t 9. Exit\e[0m "

read operation

        if [ $operation == 1 ]
        then
                OPERATN=start
        elif [ $operation == 2 ]
        then
                OPERATN=stop
        elif [ $operation == 3 ]
        then
                OPERATN=check
        elif [ $operation == 4 ]
        then
                OPERATN=restart
        elif [ $operation == 5 ]
        then
                OPERATN=start
        elif [ $operation == 6 ]
        then
                OPERATN=stop
        elif [ $operation == 7 ]
        then
                OPERATN=check
        elif [ $operation == 8 ]
        then
                OPERATN=restart
        else
                OPERATN=NULL
        fi

echo -e " \t \e[91m You have selected the $OPERATN operation to perfom on SILO $SILO and nodes are $ENG_NODE $CONN_NODE $WEB_NODE \e[0m\n"

case $operation in
        1)
          service_control_fn
          ;;
        2)
          service_control_fn
          ;;
        3)
          service_control_fn
          ;;
        4)
          service_control_fn
          ;;
        5)
          all_service_fn
          ;;
        6)
          all_check_service_fn
          ;;
        7)
          all_check_service_fn
          ;;
        8)
          all_service_fn
          ;;
esac
done
