//
//  SMBEnvironment.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBEnvironment_h
#define SMBEnvironment_h





/**
 ++ Validations
 */
#define kSMBEnvironment__validations_general_enable (DEBUG && 1)

/* SMBGameBoardTileEntity. */

#define kSMBEnvironment__SMBGameBoardTileEntity_gameBoardTileOwnership_validation_enabled (kSMBEnvironment__validations_general_enable && 1)

/* SMBGameLevelGeneratorViewController. */

#define kSMBEnvironment__SMBBeamEntityManager__beamEntity_forMarkingNodesReady_validation_general_enabled (kSMBEnvironment__validations_general_enable && 1)
#define kSMBEnvironment__SMBGameLevelView_beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled (kSMBEnvironment__validations_general_enable && 1)





#endif /* SMBEnvironment_h */
