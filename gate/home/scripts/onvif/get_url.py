from onvif import ONVIFCamera
mycam = ONVIFCamera('10.21.12.116', 1018, 'admin','admin111','/usr/local/wsdl/')

media = mycam.create_media_service()

allProfiles = media.GetProfiles()
mainProfile = media.GetProfile({'ProfileToken' : allProfiles[0]._token})

snapshot = media.GetSnapshotUri({'ProfileToken' : mainProfile._token})

print 'My Cam: ' + str(snapshot)